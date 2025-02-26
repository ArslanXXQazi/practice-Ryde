import 'package:practice_ryde/src/controllers/constants/linker.dart';
class SocialButton extends StatelessWidget {
  String image;
  String text;
  VoidCallback onPressed;
   SocialButton({super.key,
     required this.onPressed,
     required this.image,
     required this.text,
   });

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height*.01),
      child: ElevatedButton(onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.background,
            minimumSize: Size(width*1, height*.07),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: BorderSide(color: Appcolor.grey),
            shadowColor: Colors.white,
          ),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height*.05,
                width: width*.08,
                child: Image.asset(image),
              ),
              SizedBox(width: width*.03,),
              CustomText(text:text,fontSize: 16,color: Theme.of(context).colorScheme.secondary,),
            ],)
      ),
    );
  }
}
