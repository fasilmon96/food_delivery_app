 import 'package:flutter/material.dart';

class BuildDot extends StatefulWidget {
  final int index;
  final int currentIndex;
   const BuildDot({super.key,
     required this.index,
     required this.currentIndex
   });
 
   @override
   State<BuildDot> createState() => _BuildDotState();
 }
 
 class _BuildDotState extends State<BuildDot> {
   @override
   Widget build(BuildContext context) {
     return Container(
       height: 10,
       width: widget.currentIndex==widget.index?18:7 ,
       margin: EdgeInsets.only(right: 5),
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(6),
             color: Colors.black54
       ),
     );
   }
 }
