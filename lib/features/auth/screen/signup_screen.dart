import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/core/common/validations.dart';
import 'package:my_project/features/auth/controller/auth_controller.dart';
import 'package:my_project/features/auth/screen/login_screen.dart';
import 'package:my_project/model/user_model.dart';

import '../../../core/common/custom_button.dart';
import '../../../core/constant/image_constant.dart';
import '../../../core/constant/text_constant.dart';
import '../../../theme/pallete.dart';

class SignupScreen extends ConsumerStatefulWidget {
   const SignupScreen({super.key});

   @override
   ConsumerState<SignupScreen> createState() => _SignupScreenState();
 }

 class _SignupScreenState extends ConsumerState<SignupScreen> {
   TextEditingController nameController = TextEditingController();
   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
   final _formKey = GlobalKey<FormState>();
   void signupScreen(){
     UserModel userModel = UserModel(
         id: "",
         name: nameController.text.trim(),
         email: emailController.text.trim(),
         password: passwordController.text.trim(),
         profilePic: ImageConstant.avatarDefault,
         wallet: 0
     );
    ref.read(authControllerProvider).signupScreen(userModel, context);
   }




   @override
   Widget build(BuildContext context) {
     return Scaffold(
       resizeToAvoidBottomInset: false,
       backgroundColor: Pallete.whiteColor,
       body: Stack(
         children: [
           Container(
             width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height/2.5,
             decoration: BoxDecoration(
                 gradient: LinearGradient(
                     begin: Alignment.topLeft,
                     end: Alignment.bottomRight,
                     colors: [
                       Pallete.red1,
                       Pallete.red2
                     ])
             ),

           ),
           Container(
             margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/3,
             ),
             width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height/2,
             decoration: BoxDecoration(
               color: Pallete.whiteColor,
               borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
             ),
           ),
           Container(
             margin: EdgeInsets.symmetric(horizontal: 20).copyWith(
                 top: 50
             ),
             child: Column(
               children: [
                 Center(
                   child: Image.asset(ImageConstant.logo,
                     width: MediaQuery.of(context).size.width/1.5,
                     fit: BoxFit.cover,
                   ),
                 ),
                 SizedBox(height: 50,),
                 Material(
                   elevation: 5,
                   borderRadius: BorderRadius.circular(20),
                   child: Container(
                     padding: EdgeInsets.symmetric(horizontal: 20),
                     height: MediaQuery.of(context).size.height/1.5,
                     width: MediaQuery.of(context).size.width,
                     decoration: BoxDecoration(
                         color: Pallete.whiteColor,
                         borderRadius: BorderRadius.circular(20)
                     ),
                     child: Form(
                       key: _formKey,
                       child: Column(
                         children: [
                           SizedBox(height: 30,),
                           Text("Sign up",style: GoogleStyle.headlineTextFieldStyle(),),
                           SizedBox(height: 30,),
                           TextFormField(
                             controller: nameController,
                             validator: (value) {
                             return Validation.nameValidation(value!);
                             },
                             autovalidateMode: AutovalidateMode.onUserInteraction,
                             decoration: InputDecoration(
                                 hintText: "Name",
                                 hintStyle: GoogleStyle.semiBoldTextFieldStyle(),
                                 prefixIcon: Icon(Icons.person_2_outlined,),
                                 contentPadding:EdgeInsets.symmetric(vertical: 10)
                             ),
                           ),
                           SizedBox(height: 30,),
                           TextFormField(
                             controller: emailController,
                             validator: (value) {
                               return Validation.emailValidation(value!);
                             },
                             autovalidateMode: AutovalidateMode.onUserInteraction,
                             decoration: InputDecoration(
                                 hintText: "Email",
                                 hintStyle: GoogleStyle.semiBoldTextFieldStyle(),
                                 prefixIcon: Icon(Icons.email_outlined,),
                                 contentPadding:EdgeInsets.symmetric(vertical: 10)
                             ),
                           ),
                           SizedBox(height: 30,),
                           TextFormField(
                             controller: passwordController,
                             validator: (value) {
                               return Validation.passwordValidation(value!);
                             },
                             autovalidateMode: AutovalidateMode.onUserInteraction,
                             obscureText: true,
                             obscuringCharacter: "*",
                             decoration: InputDecoration(
                                 hintText: "Password",
                                 hintStyle: GoogleStyle.semiBoldTextFieldStyle(),
                                 prefixIcon: Icon(Icons.password_outlined,),
                                 contentPadding:EdgeInsets.symmetric(vertical: 10),
                             ),
                           ),
                           SizedBox(height: 60,),
                           GestureDetector(
                              onTap: () {
                                if(_formKey.currentState!.validate()){
                                  signupScreen();
                                }
                              },
                             child: CustomButton(
                               text:"SIGN UP",
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),
                 ),
                 SizedBox(height: 40,),
                 GestureDetector(
                     onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                     },
                     child: Text("Already have an account? Login",
                       style: GoogleStyle.semiBoldTextFieldStyle(),
                     )
                 )
               ],
             ),
           ),
         ],
       ),
     );
   }
 }
