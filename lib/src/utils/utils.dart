
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';


class Utils{

  void toastMsg( String msg)
  {
    toastification.show(
      //context: context,
      title: Text(msg),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

}