  import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/core/common/custom_button.dart';
import 'package:my_project/core/constant/image_constant.dart';
import 'package:my_project/core/constant/text_constant.dart';
import 'package:my_project/features/auth/controller/auth_controller.dart';
import 'package:my_project/features/auth/screen/forgotpassword_screen.dart';
import 'package:my_project/features/auth/screen/signup_screen.dart';
import 'package:my_project/theme/pallete.dart';

import '../../../core/common/validations.dart';
class LoginScreen extends ConsumerStatefulWidget {
    const LoginScreen({super.key});

    @override
    ConsumerState<LoginScreen> createState() => _LoginScreenState();
  }

  class _LoginScreenState extends ConsumerState<LoginScreen> {
   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    void loginScreen(){
      ref.read(authControllerProvider).loginScreen(
          emailController.text.trim(),
          passwordController.text.trim(),
          context
      );
    }
  @override
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
            child: Text(""),
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
                        height: MediaQuery.of(context).size.height/1.9,
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
                              Text("Login",style: GoogleStyle.headlineTextFieldStyle(),),
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
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: GoogleStyle.semiBoldTextFieldStyle(),
                                    prefixIcon: Icon(Icons.password_outlined,),
                                    contentPadding:EdgeInsets.symmetric(vertical: 10)
                                ),
                              ),
                              SizedBox(height: 20,),
                              GestureDetector(
                                 onTap: () {
                                   Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword(),));
                                 },
                                child: Container(
                                  alignment: Alignment.topRight,
                                  child: Text("Forgot Password?",
                                    style: GoogleStyle.semiBoldTextFieldStyle(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 60,),
                              GestureDetector(
                                 onTap: () {
                                   if(_formKey.currentState!.validate()){
                                    loginScreen();
                                   }
                                 },
                                child: CustomButton(
                                  text:"LOGIN",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 70,),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen(),));
                        },
                        child: Text("Don't have an account? Sign up",
                          style: GoogleStyle.semiBoldTextFieldStyle(),))
                  ],
                ),
              )
            ],
          ),
      );
    }
  }
