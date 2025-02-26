import 'package:flutter/material.dart';


//===================================================>>>>Normal Text
class CustomText extends StatelessWidget {

  String text;
  Color color;
  double fontSize;
  FontWeight fontWeight;

   CustomText({super.key,
     required this.text,
     this.color=Colors.black,
     this.fontWeight=FontWeight.normal,
     this.fontSize=14,
   });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: 'satoshi'
      ),
    );

  }
}

//===================================================>>>>Bold Text

class BoldText extends StatelessWidget {

  String text;
  Color color;
  double fontSize;
  FontWeight fontWeight;

  BoldText({super.key,
    required this.text,
    this.color=Colors.black,
    this.fontWeight=FontWeight.bold,
    this.fontSize=22,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true, // Automatically wraps text to the next line
      overflow: TextOverflow.visible,
      maxLines: 4,

      style: TextStyle(

          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          fontFamily: 'satoshi'
      ),
    );

  }
}