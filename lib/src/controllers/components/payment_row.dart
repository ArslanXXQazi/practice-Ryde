import 'package:practice_ryde/src/controllers/constants/linker.dart';

class PaymentRow extends StatelessWidget {
  String text;
  VoidCallback onTap;
  Color  backColor;
  Color  borderColor;
  Color  iconColor;
  Color  textcolor;
   PaymentRow({super.key,
     required this.onTap,
     required this.text,
     this.backColor=Colors.yellow,
     this.borderColor=Colors.yellow,
     this.iconColor=Colors.white,
     this.textcolor=Colors.yellow
   });

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: height*.006),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: text, color: textcolor,fontSize: 16,),
          InkWell(
            onTap: onTap,
            child: Container(
              height: height*.03,
              width: width*.06,
              decoration: BoxDecoration(
                color: backColor,
                shape:BoxShape.circle,
                border: Border.all(color: borderColor),
              ),
              child: Center(child: Icon(Icons.check,color: iconColor,size: 20,),),
            ),
          )
        ],),
    );
  }
}
