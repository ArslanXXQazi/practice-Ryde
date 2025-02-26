

import 'package:practice_ryde/src/controllers/constants/linker.dart';

class CancelRideRow extends StatelessWidget {
  VoidCallback onTap;
  String text;
  Color backColor;
  Color borderColor;
  Color fontColor;

   CancelRideRow({super.key,
     required this.onTap,
     required this.text,
     this.borderColor=Colors.grey,
     this.backColor=Colors.yellow,
     this.fontColor=Colors.green,
   });

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return  Row(children: [
      GestureDetector(
        onTap: onTap,
        child: Container(
          height: height*.05,
          width: width*.05,
          decoration: BoxDecoration(
              color: backColor,
              shape: BoxShape.circle,
              border: Border.all(color: borderColor)
          ),
          child: Icon(Icons.check,size: width*.04,color:Theme.of(context).colorScheme.background,),
        ),
      ),
      SizedBox(width: width*.03,),
      CustomText(
        text: text,
        fontSize: 16,
        color: fontColor,
      ),
    ]);
  }
}
