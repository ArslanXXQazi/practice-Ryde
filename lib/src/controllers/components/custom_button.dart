import 'package:practice_ryde/src/controllers/constants/linker.dart';
class CustomButton extends StatelessWidget {

  String text;
  VoidCallback onPressed;
  Color color;
  Color fontColor;
  Color borderColor;
   CustomButton({super.key,
     required this.text,
     required this.onPressed,
     this.color=Colors.yellow,
     this.fontColor=Colors.white,
     this.borderColor=Colors.grey,
   });

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Padding(
      padding:  EdgeInsets.only(top: height*.02),
      child: ElevatedButton(onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              minimumSize: Size(width*1, height*.07),
              shadowColor: Theme.of(context).colorScheme.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: borderColor),
              )
          ),
          child: CustomText(text: text,color: fontColor,fontSize: 16,)),
    );
  }
}
