import 'package:evently/model/my_user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  MyUser? user;
  void updateUser(MyUser newUser) {
    user = newUser;
    notifyListeners();
  }
}
