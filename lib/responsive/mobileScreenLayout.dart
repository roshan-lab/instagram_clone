import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/model/userModel.dart';

// String username = "";

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  @override
  void initState() {


    /////  this is just to print the user name from data base
    //getusername();
    // TODO: implement initState
    super.initState();
  }

  ///// function to print user name from data base s

  // getusername() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   setState(() {
  //     username = (snap.data() as Map<String, dynamic>)["username"];
  //   });
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(" this is mobile",
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}
