
import 'package:flutter/material.dart';
import 'package:practice_ryde/src/controllers/components/custom_text.dart';
import 'package:toastification/toastification.dart';


class Utils{

  void toastMsg( String msg, BuildContext context, Color color)
  {
    toastification.show(
      context: context,
      title: CustomText(text: msg,color: color),
      autoCloseDuration: const Duration(seconds: 5),
      type: ToastificationType.error,
      backgroundColor: Colors.white,
    );
  }

}