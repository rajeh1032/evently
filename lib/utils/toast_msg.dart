import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMsg {
  static Future<bool?> addToast(
      {required String message,
      required Color BGColor,
      required Color textColor}) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: BGColor,
        textColor: textColor,
        fontSize: 20.0);
  }
}
