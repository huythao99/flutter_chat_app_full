import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/constants/dimensions.dart';

class ErrorHandler {
  void showMessage(DioError e, BuildContext context) {
    if (e.response != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          e.response?.data['message'].toString() ?? '',
          style: TextStyle(fontSize: DimensionsCustom.calculateWidth(4)),
        )),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message.toString())),
      );
    }
  }
}
