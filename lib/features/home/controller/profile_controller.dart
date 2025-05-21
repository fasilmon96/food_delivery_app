import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/core/providers/storage_repositroy_provider.dart';
import 'package:my_project/features/profile/repository/profile_repository.dart';
import '../../../core/providers/utils.dart';
import '../../auth/screen/login_screen.dart';
 final profileControllerProvider = Provider((
     ref) => ProfileController(
     profileRepository: ref.watch(profileRepositoryProvider),
     storageRepository: ref.watch(storageRepositoryProvider),
 ),);
class ProfileController{
   final ProfileRepository _profileRepository;
   final StorageRepository _storageRepository;
   ProfileController({required ProfileRepository profileRepository,required StorageRepository storageRepository}) :
         _profileRepository=profileRepository,_storageRepository=storageRepository;

   void updateProfileImage({
     required String userId,
     required File?profilePic,
     required context
   })async{
     if(profilePic !=null){
       final imageUrl =await  _storageRepository.storeFile(
           path: "profileImage/images",
           id: userId,
           profilePic: profilePic
       );
       _profileRepository.updateProfileImage(userId, imageUrl);
       showSnackBar(text: "uploading profileImage", context: context);
     }
   }
   void logOut(BuildContext context,){
     _profileRepository.logOut();
     Navigator.pushAndRemoveUntil(
       context,
       MaterialPageRoute(builder: (context) => LoginScreen()),
           (route) => false,
     );
   }
   void deleteAccount(String id,BuildContext context){
     _profileRepository.deleteAccount(id);
     Navigator.pushAndRemoveUntil(context,
       MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false,);
   }

 }