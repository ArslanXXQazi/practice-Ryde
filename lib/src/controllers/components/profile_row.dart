import 'package:practice_ryde/src/controllers/constants/linker.dart';

class ProfileRow extends StatelessWidget {
  String image;
  String name;
  String  ratting;
  String  views;
 ProfileRow({super.key,
   required this.image,
   required this.name,
   required this.ratting,
   required this.views,
 });

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return  Padding(
      padding:  EdgeInsets.symmetric(vertical: height*.02),
      child: Row(children: [
        CircleAvatar(
          radius:width*.07,
          backgroundImage: AssetImage(image),
        ),
        SizedBox(width: width*.03,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: name,
              fontSize: 16,
              color: Theme.of(context).colorScheme.secondary,
            ),
            Row(
              children: [
                Icon(Icons.star,color: Appcolor.yellow,size: width*.05,),
                BoldText(
                  text: ' $ratting',
                  fontSize: 12,
                  color: Colors.grey,
                ),
                BoldText(
                  text: ' ( $views views )',
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
