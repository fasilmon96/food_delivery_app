import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_providers.dart';

   final storageRepositoryProvider =Provider((ref) => StorageRepository(
       firebaseStorage: ref.watch(storageProvider)),
   );

   class StorageRepository{
     final FirebaseStorage _firebaseStorage;
     StorageRepository({required FirebaseStorage firebaseStorage}):_firebaseStorage=firebaseStorage;

     Future <String> storeFile({
        required String path,
        required String id,
        required File?profilePic,
   })async{
       try{
         final ref = _firebaseStorage.ref().child(path).child(id);
         UploadTask uploadTask;
          uploadTask = ref.putFile(profilePic!,SettableMetadata(contentType: 'image/jpeg'));
         final snapShot = await uploadTask;
         return await snapShot.ref.getDownloadURL();
       }catch(e){
         throw Exception('File upload failed: $e');
       }
     }

   }




