
import 'package:flutter/material.dart';
import 'package:practice_ryde/src/controllers/components/custom_text.dart';
import 'package:toastification/toastification.dart';


class Utils{

  void toastMsg( String msg, BuildContext context, Color color, ToastificationType type)
  {
    toastification.show(
      context: context,
      title: CustomText(text: msg,color: color),
      autoCloseDuration: const Duration(seconds: 3),
      type: type,
      backgroundColor:Theme.of(context).colorScheme.secondary,
      progressBarTheme: ProgressIndicatorThemeData(
        color: 
      )
    );
  }

}