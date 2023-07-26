import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:instagram/resources/storageMethods.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  Future<String> SignUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some Error Occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        ///// register the user  /////
        UserCredential cred = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String photoURL = await StorageMethods()
            .uploadImageToStorage("profilePics", file, false);

        ///////////  add user to data base  //////
        print("cred user is ${cred.user!.uid}");
        await fireStore.collection("users").doc(cred.user!.uid).set({
          "username": username,
          "uid": cred.user!.uid,
          "email": email,
          "bio": bio,
          "followers": [],
          "following": [],
          "photoURL": photoURL,
        });
        res = "Success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == "invalid-email") {
        res = "Email is badly formatted";
      } else if (err.code == "weak-password") {
        res = "Weak Password";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //////////////   login user /////////
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res="Some error occured";
    try{
      if(email.isNotEmpty || password.isNotEmpty){
        await auth.signInWithEmailAndPassword(email: email, password: password);
        res="Success";
      }
      else {
        res= "Please enter all the fields";
      }
    }
    on FirebaseAuthException catch (err){
      if(err.code=="user-not-found"){
        res = "User not found";
      }
      if(err.code=="wrong-password"){
        res="Wrong Password";
      }
    }
    catch(err){
      res=err.toString();
    }
    return res;
  }
}
