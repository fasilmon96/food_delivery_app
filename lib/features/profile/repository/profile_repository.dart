import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/core/constant/firebase_constant.dart';
import 'package:my_project/core/providers/firebase_providers.dart';

final profileRepositoryProvider = Provider(
  (ref) => ProfileRepository(firestore: ref.watch(firestoreProvider), auth: ref.watch(authProvider)),
);

class ProfileRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  ProfileRepository({required FirebaseFirestore firestore,required FirebaseAuth auth})
    : _firestore = firestore,
    _auth =auth;
  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  void updateProfileImage(String id, String image) async {
    await _users.doc(id).update({"profilePic": image});
  }
  void logOut() async {
    await _auth.signOut();
  }

  void deleteAccount(String id) async {
    await _auth.currentUser!.delete();
    await _users.doc(id).delete();
  }
}
