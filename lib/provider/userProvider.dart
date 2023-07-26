import 'package:flutter/cupertino.dart';
import 'package:instagram/model/userModel.dart';
import 'package:instagram/resources/authMethods.dart';

class UserProvider extends ChangeNotifier{
  User?_user;
  final AuthMethods authMethods=AuthMethods();
  User get getUser=>_user!;
  Future<void> refreshUser()async{
    User user=await authMethods.getUserDetails();
    _user=user;
    notifyListeners();
  }
}