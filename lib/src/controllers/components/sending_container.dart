

import 'package:practice_ryde/src/controllers/constants/linker.dart';

class SendingContainer extends StatelessWidget {
  String text;
   SendingContainer({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Padding(
      padding:  EdgeInsets.only(top: height*.03),
      child: Container(
        width: width*.9,
        decoration: BoxDecoration(
            color: Appcolor.orange,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomLeft:  Radius.circular(20),
              topLeft:  Radius.circular(20),
            )
        ),
        child:Padding(
          padding: EdgeInsets.symmetric(vertical: height*.03,horizontal: width*.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: text,color: Colors.black,fontSize: 14,)
            ],),
        ),
      ),
    );
  }
}
