
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';


class Utils{

  void toastMsg( String msg, BuildContext context)
  {
    toastification.show(
      context: context,
      title: Text(msg),
      autoCloseDuration: const Duration(seconds: 5),
      type: ToastificationType.error,
      primaryColor: Colors.green,
      backgroundColor: Colors.white,
    );
  }

}