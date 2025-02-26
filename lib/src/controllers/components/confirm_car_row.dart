import 'package:practice_ryde/src/controllers/constants/linker.dart';

class ConfirmCarRow extends StatelessWidget {
  String image;
  String carType;
  String duration;
  String fixedORMetered;
  String price;
  VoidCallback ontap;
  Color backColor;
  Color borderColor;
   ConfirmCarRow({super.key,
     required this.ontap,
     required this.image,
     required this.carType,
     required this.duration,
     required this.price,
     required this.fixedORMetered,
     this.backColor=Colors.white,
     this.borderColor=Colors.white,
   });

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: height*.005),
        child: Container(
          decoration: BoxDecoration(
            color: backColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor)
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width*.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Container(
                    height: height*.1,
                    width: width*.2,
                    child: Image(image: AssetImage(image)),
                  ),
                  SizedBox(width: width*.03,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: carType,fontSize: 16,color:Theme.of(context).colorScheme.secondary,),
                      SizedBox(height: height*.005,),
                      CustomText(text: duration,fontSize: 12,color:Theme.of(context).colorScheme.tertiary),
                    ],
                  ),
                ],),
                Column(
                 crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BoldText(text: fixedORMetered,fontSize: 13, color: Theme.of(context).colorScheme.secondary),
                    SizedBox(height: height*.005,),
                    BoldText(text: '\$$price',fontSize: 16, color: Theme.of(context).colorScheme.primary),
                  ],
                ),
              ],),
          ),
        ),
      ),
    );
  }
}


