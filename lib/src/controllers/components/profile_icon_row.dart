import 'package:practice_ryde/src/controllers/constants/linker.dart';
class ProfileIconRow extends StatelessWidget {
  String image;
  String text;
  VoidCallback onTap;
   ProfileIconRow({super.key,
     required this.onTap,
     required this.image,
     required this.text});

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: height*.02),
        child: Row(children: [
          CircleAvatar(
            backgroundColor: Appcolor.yellow.withOpacity(.15),
            radius: width*.055,
            child: Image(image: AssetImage(image)),
          ),
          SizedBox(width: width*.04,),
          Column(
            children: [
              CustomText(text: text,color: Theme.of(context).colorScheme.secondary,fontSize: 16,),
            ],
          ),
        ],),
      ),
    );
  }
}
