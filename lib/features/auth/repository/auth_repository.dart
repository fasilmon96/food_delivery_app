import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/core/constant/firebase_constant.dart';
import 'package:my_project/core/providers/firebase_providers.dart';
import 'package:my_project/core/providers/widgets.dart';
import 'package:my_project/features/auth/screen/newpassword.dart';
import 'package:my_project/model/user_model.dart';
import '../../../core/providers/utils.dart';
import '../../bottomnavigation/screen/bottomnavigation_screen.dart';
import '../screen/login_screen.dart';
final authRepositoryProvider = Provider((ref) => AuthRepository(
    firestore: ref.watch(firestoreProvider),
    auth: ref.watch(authProvider),
    ref: ref
),);
class AuthRepository{
    final FirebaseFirestore _firestore;
    final FirebaseAuth _auth;
    final Ref _ref;
    AuthRepository({
      required FirebaseFirestore firestore,
      required FirebaseAuth auth,required Ref ref}) : _firestore = firestore, _auth = auth,_ref=ref;
    
    CollectionReference get _users => _firestore.collection(FirebaseConstants.usersCollection);
    Stream<User?> get  authStateChanges => _auth.authStateChanges();
    void signupScreen(UserModel user,context) async {
      try {

        UserCredential  userCredential = await _auth.createUserWithEmailAndPassword(
            email: user.email, password: user.password);
        if (userCredential.additionalUserInfo!.isNewUser) {
          UserModel userModel = UserModel(
              id: userCredential.user!.uid,
              name: user.name,
              email: user.email,
              password: user.password,
              profilePic: user.profilePic,
              wallet: user.wallet,
          );
          await _users.doc(userCredential.user!.uid).set(userModel.toJson());
          showSnackBar(text: "Registration Successfully", context: context);
          _ref.read(pageProvider.notifier).state=0;
          await Future.delayed(const Duration(seconds: 1));
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavigationScreen(),
            ),
                (route) => false,
          );
        } else {
          await getUserData(userCredential.user!.uid).first;
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == "email-already-in-use") {
          showSnackBar(text: "email address is already in use", context: context);
        }
      } catch (e) {
        showSnackBar(text: e.toString(), context: context);
      }
    }
    void loginScreen(
        String email,
        String password,
        context,
        ) async {
      try {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        showSnackBar(text: "Login Successfully", context: context);
        _ref.read(pageProvider.notifier).state=0;
        await Future.delayed(const Duration(seconds: 1));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavigationScreen(),
          ),
              (route) => false,
        );
      }on FirebaseAuthException catch(e){
        if(e.code == "invalid-credential"){
          showSnackBar(text: "invalid email and password", context: context);
        }
      }
      catch(e){
        showSnackBar(text: e.toString(), context: context);
      }
    }

    Stream<UserModel> getUserData(String uid) {
      return _users.doc(uid).snapshots().map(
            (event) => UserModel.fromJson(event.data() as Map<String, dynamic>),
      );
    }
    void resetPassword(String email,context,WidgetRef ref)async {
      try {
        QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
            .instance
            .collection(FirebaseConstants.usersCollection)
            .where("email", isEqualTo: email)
            .get();

        if (data.docs.isEmpty) {
          showSnackBar(text: "User not found that Email ❌", context: context);
        }else{
          final userId = data.docs.first.id;
          ref.read(userIdProvider.notifier).state=userId;
          await _auth.sendPasswordResetEmail(email: email);
          await Future.delayed(Duration(seconds: 1));
          showSnackBar(text: "Reset link sent to $email ✅ ", context: context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewPassword(),));
        }


      } catch (e) {
        showSnackBar(text: e.toString(), context: context);
      }

    }

    void updatePassword(String password,context,WidgetRef ref)async{
       final userId = ref.watch(userIdProvider);
      await _users.doc(userId).update({"password":password});
       showSnackBar(text: "Password has been Changed ✅ ", context: context);
       await Future.delayed(Duration(seconds: 1));
       Navigator.pushAndRemoveUntil(
           context, MaterialPageRoute(
         builder: (context) => LoginScreen(),), (route) => false,);
    }


}