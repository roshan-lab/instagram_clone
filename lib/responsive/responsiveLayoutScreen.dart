import 'package:flutter/material.dart';
import 'package:instagram/provider/userProvider.dart';
import 'package:provider/provider.dart';


class ResponsiveLayout extends StatefulWidget {

  final webScreenLayout;
  final mobileScreenLayout;

  const ResponsiveLayout({super.key,required this.webScreenLayout,required this.mobileScreenLayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override

  void initState() {
    setState(() {
      addData();
    });
    // TODO: implement initState
    super.initState();
  }

  addData()async{
    UserProvider userProvider=Provider.of(context,listen: false);
    await userProvider.refreshUser();
  }

  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
      if(constraints.maxWidth>600){
        return widget.webScreenLayout;
      }
      return widget.mobileScreenLayout;
    });
  }
}
