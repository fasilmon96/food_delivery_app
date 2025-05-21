 import 'package:my_project/core/constant/image_constant.dart';

class UnBoardingContent{
  String description;
  String image;
  String title;

  UnBoardingContent({required this.description,required this.image,required this.title });

}

 List<UnBoardingContent> contents=[
   UnBoardingContent(
     description: "Pick your food from our menu\n   More than 35 times",
     image: ImageConstant.screen1,
     title: "Select from Our\nBest Menu",
   ),
   UnBoardingContent(
       description: "You can pay cash on delivery and\nCard payment is available ",
       image: ImageConstant.screen2,
       title: "Easy and Online Payment",
   ),

   UnBoardingContent(
       description: "Delivery your food at your\nDoorstep",
       image: ImageConstant.screen3,
       title: "Quick Delivery at Your Doorstep",
   )


 ];