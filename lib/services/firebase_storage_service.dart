import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:newflutter/services/storage_base.dart';

class FirebaseStorageService implements StorageBase{
  final FirebaseStorage _firebaseStorage=FirebaseStorage.instance;
  StorageReference _storageReference;
  @override
  Future<String> uploadFile(String userId, String fileType, File yuklenecekDosya) async{
    _storageReference=_firebaseStorage.ref().child(userId).child(fileType).child("profil_foto.png");
    var _uploadTask=_storageReference.putFile(yuklenecekDosya);

    var url= await (await _uploadTask.onComplete).ref.getDownloadURL();
   return url;
  }

}