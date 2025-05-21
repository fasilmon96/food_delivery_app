import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../theme/pallete.dart';

void showSnackBar({required String text, required BuildContext context}){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text,style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Pallete.whiteColor
      ),
      ),
        backgroundColor: Pallete.message,
      ),
  );

}

// void emailOTP(context,String email)async{
//    EmailOTP.config(
//        appName: 'Food App',
//        otpType: OTPType.numeric,
//        emailTheme: EmailTheme.v1,
//        otpLength: 6
//    );
//       bool result =await EmailOTP.sendOTP(email: email);
//    if(result){
//    showSnackBar(text: "OTP has been sent", context: context);
//    await Future.delayed(Duration(seconds: 1));
//     Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationCode(),));
//    }else{
//      showSnackBar(text: "OTP sending failed", context: context);
//    }
// }
//
//  void verifyOTP(context, String otp,WidgetRef ref)async{
//       bool result = EmailOTP.verifyOTP(otp: otp);
//    if(result){
//       ref.read(otpVerifiedProvider.notifier).state=true;
//      showSnackBar(text: "OTP Verified", context: context);
//      await Future.delayed(Duration(seconds: 1));
//      Navigator.push(context, MaterialPageRoute(builder: (context) => NewPassword(),));
//    }else{
//      ref.read(otpVerifiedProvider.notifier).state=false;
//     showSnackBar(text: "Please Check correct Verify Code", context: context);
//    }
//  }
Future<File?>pickImageGallery()async{
  File? image;
  try{
    final pickedImage = await ImagePicker().pickImage(source:ImageSource.gallery);
    if(pickedImage != null){
      image = File(pickedImage.path);
    }
  }catch(e){
    e.toString();
  }
  return image;
}








