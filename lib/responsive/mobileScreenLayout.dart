import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/model/userModel.dart';
import 'package:instagram/provider/userProvider.dart';
import 'package:instagram/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:instagram/model/userModel.dart' as model;
// String username = "";

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int page=0;
  late PageController pageController;
  navigationTapped(int page){
    pageController.jumpToPage(page);
  }
  @override
  void initState() {

    pageController=PageController();
    /////  this is just to print the user name from data base
    //getusername();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    // TODO: implement dispose
    super.dispose();
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

  onPageChange(int _page){
    setState(() {
      page=_page;
    });
  }

  Widget build(BuildContext context) {

    //// by this we can show any data of user to screen
    //model.User user=Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChange,
        children: [
          Text("feed"),
          Text("fe"),
          Text("ed"),
          Text("eed"),
          Text("f"),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,color: page==0?primaryColor:secondaryColor,),label: "",backgroundColor: primaryColor),
          BottomNavigationBarItem(icon: Icon(Icons.search,color: page==1?primaryColor:secondaryColor),label: "",backgroundColor: primaryColor),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle,color: page==2?primaryColor:secondaryColor),label: "",backgroundColor: primaryColor),
          BottomNavigationBarItem(icon: Icon(Icons.favorite,color: page==3?primaryColor:secondaryColor),label: "",backgroundColor: primaryColor),
          BottomNavigationBarItem(icon: Icon(Icons.person,color: page==4?primaryColor:secondaryColor),label: "",backgroundColor: primaryColor),
        ],
        onTap: navigationTapped,
      ),
      // body: Center(
      //     child: Text("mobile",
      //   style: TextStyle(color: Colors.white),
      // )),
    );
  }
}
