import 'package:practice_ryde/src/controllers/constants/linker.dart';

class NotificationContainer extends StatelessWidget {

  VoidCallback onTap;
  String text;
  String time;

   NotificationContainer({super.key,

     required this.onTap,
     required this.text,
     required this.time,
   });

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: height*.01),
      child: GestureDetector(
        onTap: onTap,
        child: Row(children: [
          CircleAvatar(
            backgroundColor: Appcolor.yellow.withOpacity(.15),
            radius: width*.055,
            child: Image(image: AssetImage(Appimages.notificationIcon)),
          ),
          SizedBox(width: width*.04,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoldText(text: text,color: Theme.of(context).colorScheme.secondary,fontSize: 16,),
                CustomText(text: time,color: Colors.grey,fontSize: 13,),
              ],
            ),
          ),
        ],),
      ),
    );
  }
}
