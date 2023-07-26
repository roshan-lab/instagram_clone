import 'package:flutter/material.dart';


class ResponsiveLayout extends StatelessWidget {

  final webScreenLayout;
  final mobileScreenLayout;

  const ResponsiveLayout({super.key,required this.webScreenLayout,required this.mobileScreenLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
      if(constraints.maxWidth>600){
        return webScreenLayout;
      }
      return mobileScreenLayout;
    });
  }
}
