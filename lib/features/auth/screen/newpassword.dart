import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/core/common/custom_button.dart';
import 'package:my_project/core/common/validations.dart';
import 'package:my_project/features/auth/controller/auth_controller.dart';
import 'package:my_project/theme/pallete.dart';
import '../../../core/constant/meadiaquery_value.dart';
class NewPassword extends ConsumerStatefulWidget {
  const NewPassword({super.key});

  @override
  ConsumerState<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends ConsumerState<NewPassword> {
  TextEditingController passwordController=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void updatePassword(){
    ref.read(authControllerProvider).updatePassword(
        passwordController.text,
        context,
      ref
    );
  }



  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Pallete.message1,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 80,horizontal: 20),
        child: Column(
          children: [
            Text("NewPassword",style: GoogleFonts.poppins(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Pallete.whiteColor
            ),),
            SizedBox(height: 5,),
            Text("Please Enter New Password",style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Pallete.whiteColor
            ),),
            SizedBox(height: 40,),
            Form(
               key: _formKey,
              child: TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return Validation.passwordValidation(value!);
                },
                decoration: InputDecoration(
                  hintText: "Password...",
                  hintStyle: TextStyle(
                      color: Pallete.blackColor,
                      fontSize:18
                  ),
                  fillColor: Pallete.textColor,
                  filled: true,
                  prefixIcon: Icon(Icons.password),
                  suffix: InkWell(
                      onTap: () {
                        passwordController.clear();
                      },
                      child: Icon(Icons.clear)),
                  contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Please write your new password.",
              style: GoogleFonts.poppins(
                color: Colors.green,
                fontSize: 12,
              )
            ),
            SizedBox(
              height: 60,
            ),

          GestureDetector(
             onTap: () {
               if(_formKey.currentState!.validate()){
                 updatePassword();
               }
             },
              child: CustomButton(text: "Reset Password"))
          
          ],
        ),
      )
    );
  }
}