 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/theme/pallete.dart';

class CustomButton extends StatefulWidget {
   final String text;
   const CustomButton({super.key,
     required this.text,
   });

   @override
   State<CustomButton> createState() => _CustomButtonState();
 }

 class _CustomButtonState extends State<CustomButton> {
   @override
   Widget build(BuildContext context) {
     return Material(
       elevation: 5,
         borderRadius: BorderRadius.circular(10),
         shadowColor: Pallete.blackColor,
         child: Container(
         padding: EdgeInsets.symmetric(vertical: 12),
         alignment: Alignment.center,
         width: 200,
         decoration: BoxDecoration(
           color: Pallete.red3,
           borderRadius: BorderRadius.circular(10)
         ),
         child: Text(widget.text,style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Pallete.whiteColor
         )
         ),
                ),
     );
   }
 }
