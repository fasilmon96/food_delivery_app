import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_project/core/constant/meadiaquery_value.dart';
import 'package:my_project/core/constant/text_constant.dart';
import 'package:my_project/features/auth/controller/auth_controller.dart';
import 'package:my_project/features/home/controller/profile_controller.dart';
import 'package:my_project/theme/pallete.dart';

import '../../../core/providers/utils.dart';

class ProfileScreen extends ConsumerStatefulWidget {
   const ProfileScreen({super.key});

   @override
   ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
 }

 class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  File? image;
   void selectProfileImage() async {
     image = await pickImageGallery();
     setState(() {});
   }
   void updateProfileImage(){
      final user = ref.watch(userProvider)!;
     ref.read(profileControllerProvider).updateProfileImage(
         userId: user.id,
         profilePic: image,
         context: context
     );
   }
   void logOut(){
     ref.read(profileControllerProvider).logOut(context);
   }
   void deleteAccount(String id){
     ref.read(profileControllerProvider).deleteAccount(id,context);
   }
   @override
   Widget build(BuildContext context) {
     final user = ref.watch(userProvider)!;
     return Scaffold(
       backgroundColor: Pallete.whiteColor,
       body: Column(
           children: [
             Stack(
               children: [
                 Container(
                   padding: EdgeInsets.only(top: 45,right: 20,left: 20),
                   height: SizeConfig.screenHeight/4.3,
                   width: SizeConfig.screenWidth,
                   decoration: BoxDecoration(
                     color: Colors.black,
                     borderRadius: BorderRadius.vertical(
                       bottom: Radius.elliptical(SizeConfig.screenWidth, 105)
                     )
                   ),
                 ),
                 GestureDetector(
                    onTap: () {
                      selectProfileImage();
                    },
                   child: Column(
                     children: [
                       Center(
                         child: Container(
                           margin: EdgeInsets.only(top: SizeConfig.screenHeight/6.5),
                           child: Material(
                             elevation: 10,
                             borderRadius: BorderRadius.circular(60),
                             child: ClipRRect(
                               borderRadius: BorderRadius.circular(60),
                               child: image!=null?Image.file(image!,fit: BoxFit.cover,width: 120,height: 120,):
                                Image.network(user.profilePic,fit: BoxFit.cover,width: 120,height: 120,),
                             ),
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
                  Container(
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.symmetric(horizontal:20,vertical: 10),
                    child: TextButton(
                        onPressed: (){
                          updateProfileImage();
                        },
                        child:Text("Save",style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Pallete.message5,
                          fontWeight: FontWeight.bold
                        ),)
                    ),
                  ),
                 Center(
                   heightFactor: 5,
                   child: Text(
                     user.name,style: GoogleFonts.poppins(
                      fontSize: 23,
                     color: Pallete.message4,
                     fontWeight: FontWeight.bold
                   )),
                 )
               ],
             ),
             SizedBox(height: 40,),
             Container(
               margin: EdgeInsets.symmetric(horizontal: 20),
               decoration: BoxDecoration(
                   color: Pallete.message3,
                   borderRadius: BorderRadius.circular(10),
                 boxShadow: [
                   BoxShadow(
                     color: Pallete.message2.withValues(alpha: 1),
                     blurRadius: 0.6,
                     spreadRadius: 0.4,
                     offset: Offset(0, 4)
                   )
                 ]
               ),
               child: ListTile(
                 leading: Icon(Icons.person,size: 30,color: Pallete.blackColor,),
                 contentPadding: EdgeInsets.symmetric(horizontal: 20),
                 horizontalTitleGap: 25,
                 title: Text("Name",style:GoogleStyle.lightTextFieldStyle(),),
                 subtitle: Text(user.name,style: GoogleStyle.semiBoldTextFieldStyle(),),
               ),
             ),
             SizedBox(height:20,),
             Container(
               margin: EdgeInsets.symmetric(horizontal: 20),
               decoration: BoxDecoration(
                   color: Pallete.message3,
                   borderRadius: BorderRadius.circular(10),
                   boxShadow: [
                     BoxShadow(
                         color: Pallete.message2.withValues(alpha: 1),
                         blurRadius: 0.6,
                         spreadRadius: 0.4,
                         offset: Offset(0, 4)
                     )
                   ]
               ),
               child: ListTile(
                 leading: Icon(Icons.email,size: 30,color: Pallete.blackColor,),
                 contentPadding: EdgeInsets.symmetric(horizontal: 20),
                 horizontalTitleGap: 25,
                 title: Text("Email",style:GoogleStyle.lightTextFieldStyle(),),
                 subtitle: Text(user.email,style: GoogleFonts.poppins(
                   fontSize: 14,
                   color: Pallete.blackColor,
                   fontWeight: FontWeight.w500
                 ),),
               ),
             ),
             SizedBox(height:20,),
             Container(
               margin: EdgeInsets.symmetric(horizontal: 20),
               decoration: BoxDecoration(
                   color: Pallete.message3,
                   borderRadius: BorderRadius.circular(10),
                   boxShadow: [
                     BoxShadow(
                         color: Pallete.message2.withValues(alpha: 1),
                         blurRadius: 0.6,
                         spreadRadius: 0.4,
                         offset: Offset(0, 4)
                     )
                   ]
               ),
               child: ListTile(
                 leading: Icon(Icons.description_outlined,size: 30,color: Pallete.blackColor,),
                 contentPadding: EdgeInsets.symmetric(horizontal: 20),
                 horizontalTitleGap: 25,
                 title: Text("Terms and Condition",style: GoogleStyle.semiBoldTextFieldStyle(),),
               ),
             ),
             SizedBox(height:20,),
             GestureDetector(
                onTap: () {
                  deleteAccount(user.id);
                },
               child: Container(
                 margin: EdgeInsets.symmetric(horizontal: 20),
                 decoration: BoxDecoration(
                     color: Pallete.message3,
                     borderRadius: BorderRadius.circular(10),
                     boxShadow: [
                       BoxShadow(
                           color: Pallete.message2.withValues(alpha: 1),
                           blurRadius: 0.6,
                           spreadRadius: 0.4,
                           offset: Offset(0, 4)
                       )
                     ]
                 ),
                 child: ListTile(
                   leading: Icon(Icons.delete,size: 30,color: Pallete.blackColor,),
                   contentPadding: EdgeInsets.symmetric(horizontal: 20),
                   horizontalTitleGap: 25,
                   title: Text("Delete Account",style: GoogleStyle.semiBoldTextFieldStyle(),),
                 ),
               ),
             ),
             SizedBox(height:20,),
             GestureDetector(
                onTap: () {
                  logOut();
                },
               child: Container(
                 margin: EdgeInsets.symmetric(horizontal: 20),
                 decoration: BoxDecoration(
                     color: Pallete.message3,
                     borderRadius: BorderRadius.circular(10),
                     boxShadow: [
                       BoxShadow(
                           color: Pallete.message2.withValues(alpha: 1),
                           blurRadius: 0.6,
                           spreadRadius: 0.4,
                           offset: Offset(0, 4)
                       )
                     ]
                 ),
                 child: ListTile(
                   leading: Icon(Icons.logout,size: 30,color: Pallete.blackColor,),
                   contentPadding: EdgeInsets.symmetric(horizontal: 20),
                   horizontalTitleGap: 25,
                   title: Text("LogOut",style: GoogleStyle.semiBoldTextFieldStyle(),),
                 ),
               ),
             ),
           ],
       ),
     );
   }
 }
