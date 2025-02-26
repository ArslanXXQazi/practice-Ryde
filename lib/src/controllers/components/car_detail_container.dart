import 'package:practice_ryde/src/controllers/constants/linker.dart';

class CarDetailContainer extends StatelessWidget {

  String image;
  String name;
  String carNumber;
  String price;

   CarDetailContainer({super.key,
     required this.image,
     required this.name,
     required this.carNumber,
     required this.price,
   });

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: height*.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Container(
              height: height*.08,
              width: width*.21,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(image: AssetImage(image)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoldText(
                  text: name,
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                SizedBox(height: height*.003,),
                BoldText(
                  text: carNumber,
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ],
            ),
          ],),
          BoldText(
            text: '\$$price',
            fontSize: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
        ],),
    );
  }
}
