import 'package:practice_ryde/src/controllers/constants/linker.dart';
class CarSelectContainer extends StatelessWidget {
  String image;
  String carTape;
  VoidCallback ontap;
  Color color;
  Color borderColor;
   CarSelectContainer({super.key,
     required this.ontap,
     required this.image,
     required this.carTape,
     this.color=Colors.white,
     this.borderColor=Colors.grey,
   });

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return  Padding(
      padding:  EdgeInsets.symmetric(vertical: height*.017),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          height: height*.13,
          width: width*.29,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage(image)),
              CustomText(text: carTape,color: Theme.of(context).colorScheme.secondary,),
            ],),
        ),
      ),
    );
  }
}
