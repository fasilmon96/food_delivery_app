import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/theme/pallete.dart';

class GoogleStyle{
   static   boldTextFieldStyle(){
        return GoogleFonts.poppins(
           fontSize: 20,
           fontWeight: FontWeight.bold,
           color: Pallete.blackColor
        );
     }
   static   semiBoldTextFieldStyle(){
     return GoogleFonts.poppins(
         fontSize: 16,
         fontWeight: FontWeight.w500,
         color: Pallete.blackColor
     );

   }
   static   headlineTextFieldStyle(){
        return GoogleFonts.poppins(
           fontSize: 24,
           fontWeight: FontWeight.bold,
           color: Pallete.blackColor
        );
     }

   static   lightTextFieldStyle(){
     return GoogleFonts.poppins(
         fontSize: 14,
         fontWeight: FontWeight.w500,
         color: Colors.black38
     );

   }
   static   semiTextFieldStyle(){
     return GoogleFonts.poppins(
         fontSize: 15,
         fontWeight: FontWeight.w500,
         color: Pallete.blackColor
     );

   }
   }

