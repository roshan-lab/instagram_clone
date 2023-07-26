import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/resources/authMethods.dart';
import 'package:instagram/responsive/mobileScreenLayout.dart';
import 'package:instagram/responsive/responsiveLayoutScreen.dart';
import 'package:instagram/responsive/webScreenLayout.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/utils.dart';
import 'package:instagram/widgets/textFieldInput.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  Uint8List ? image;
  bool isLoading=false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    usernameController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    void selectImage()async{
     Uint8List im= await pickImage(ImageSource.gallery);
     setState(() {
       image=im;
     });
    }

    void SignUpUser()async {
      setState(() {
        isLoading=true;
      });
      String res =await AuthMethods().SignUpUser(
        email: emailController.text,
        password: passwordController.text,
        username: usernameController.text,
        bio: bioController.text,
        file: image!,
      );
      print("on tap res is $res");
      setState(() {
        isLoading=false;
      });
      if(res == "Success"){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ResponsiveLayout(
          webScreenLayout: WebScreenLayout(),
          mobileScreenLayout: MobileScreenLayout(),
        ),
        ),
        );
      }
      if(res != "Success"){
        showSnackBar(context, res);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              SvgPicture.asset(
                "assets/ic_instagram.svg",
                color: primaryColor,
                height: 64,
              ),
              SizedBox(
                height: 24,
              ),
              Stack(
                children: [
                  image!=null?
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: MemoryImage(image!),
                  ):
                  CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Windows_10_Default_Profile_Picture.svg/2048px-Windows_10_Default_Profile_Picture.svg.png"),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: () {
                        selectImage();
                      },
                      icon: Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 64,
              ),
              TextFieldInput(
                  textEditingController: usernameController,
                  hintText: "Enter your username",
                  textInputType: TextInputType.text),
              SizedBox(
                height: 24,
              ),
              TextFieldInput(
                  textEditingController: emailController,
                  hintText: "Enter your email",
                  textInputType: TextInputType.emailAddress),
              SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: passwordController,
                hintText: "Enter your password",
                textInputType: TextInputType.text,
                isPass: true,
              ),
              SizedBox(
                height: 24,
              ),
              TextFieldInput(
                  textEditingController: bioController,
                  hintText: "Enter your bio",
                  textInputType: TextInputType.text),
              SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  SignUpUser();

                  },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: ShapeDecoration(
                    color: blueColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                  ),
                  child:isLoading?Center(child: CircularProgressIndicator(color: primaryColor,)): Text("Sign up"),
                ),
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       child: Text(
              //         "Don't have an account?",
              //       ),
              //       padding: EdgeInsets.symmetric(vertical: 8),
              //     ),
              //     GestureDetector(
              //       onTap: () {},
              //       child: Container(
              //         child: Text(
              //           "Sign up",
              //           style: TextStyle(fontWeight: FontWeight.bold),
              //         ),
              //         padding: EdgeInsets.symmetric(vertical: 8),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

