import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';



class StorageMethods{
  FirebaseAuth auth=FirebaseAuth.instance;
  final FirebaseStorage storage=FirebaseStorage.instance;
  Future<String> uploadImageToStorage(String childName, Uint8List file, bool isPost) async {
    Reference ref=storage.ref().child(childName).child(auth.currentUser!.uid);
    UploadTask uploadTask=ref.putData(file);
    TaskSnapshot snap=await uploadTask;
    String downloadURL=await snap.ref.getDownloadURL();
    return downloadURL;
  }
}