import 'package:practice_ryde/src/controllers/constants/linker.dart';
class SuggestedLocation extends StatelessWidget {
  String image;
  String location;
   SuggestedLocation({super.key,
     required this.image,
     required this.location,
   });

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: height*.01),
      child: GestureDetector(
        onTap: (){},
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
          CircleAvatar(
            backgroundColor: Appcolor.yellow.withOpacity(.09),
            radius: width*.055,
            child: Image(image: AssetImage(image)),
          ),
          SizedBox(width: width*.04,),
          Expanded(child:
          CustomText(text: location,color: Theme.of(context).colorScheme.secondary,fontSize: 16,fontWeight: FontWeight.w600,)),
        ],),
      ),
    );
  }
}
