import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/core/common/custom_button.dart';
import 'package:my_project/core/common/validations.dart';
import 'package:my_project/features/auth/controller/auth_controller.dart';
import 'package:my_project/theme/pallete.dart';


class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}


class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  TextEditingController emailController=TextEditingController();
  final _formKey1 = GlobalKey<FormState>();
  void restPassword(){
    ref.read(authControllerProvider).restPassword(emailController.text,context,ref);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Pallete.message1,
      body:
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 80),
       child: Form(
         key: _formKey1,
         child: Column(
              children: [
                Text("Password Recovery",style:GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Pallete.textColor
                )
                ),
                SizedBox(height: 5,),
                Text("Enter your Email",style:GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Pallete.textColor
                )
                ),

                SizedBox(height: 30,),
                Padding(
                  padding:  EdgeInsets.all(10),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.go,
                    validator: (value) {
                      return Validation.emailValidation(value!);
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                        hintText: "Email Address",
                        hintStyle: TextStyle(
                            color: Colors.black54,fontSize:16
                        ),
                        filled: true,
                        fillColor: Pallete.textColor,
                        contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                        prefixIcon: Icon(Icons.person),
                        suffix: InkWell(
                            onTap: () {
                              emailController.clear();
                            },
                            child: Icon(Icons.clear)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)
                        ),
                    ),

                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Please write your email to receive a confirmation\n code to set a new password.",
                      style: TextStyle(
                          color: Colors.green,
                      ),textAlign: TextAlign.center,
                    )
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(_formKey1.currentState!.validate()){
                         restPassword();
                        }
                      },
                      child: CustomButton(text: "Confirm Mail"),
                    )
                  ],
                )
              ],
            ),
       )
      ),
    );
  }
}