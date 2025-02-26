
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';


class Utils{

  void toastMsg()
  {
    toastification.show(
      context: context,
      title: Text('Hello, world!'),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

}