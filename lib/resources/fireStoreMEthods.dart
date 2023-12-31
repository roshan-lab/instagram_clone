import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:instagram/model/post.dart';
import 'package:instagram/resources/storageMethods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  ///// upload post

Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
    )async{
  String res="Some error occur";
  try{
    String photoURL=await StorageMethods().uploadImageToStorage("posts", file, true);

    String postId=const Uuid().v1();

    Post post=Post(
      description:description,
      uid:uid,
      username:username,
      postId:postId,
      datePublished:DateTime.now(),
      postURL:photoURL ,
      profImage:profImage,
      likes: [],
    );
    _firestore.collection("posts").doc(postId).set(post.toJson());
    res="Success";
  }
  catch(err){
    res=err.toString();
  }
  return res;
}
}