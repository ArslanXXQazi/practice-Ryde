import 'package:practice_ryde/src/controllers/constants/linker.dart';

class RecevingContainer extends StatelessWidget {
  String text;
   RecevingContainer({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.only(top: height*.03),
      child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
            Expanded(
              flex: 15,
              child: Column(
                children: [
                CircleAvatar(
                  radius: width*.04,
                  backgroundImage: AssetImage(Appimages.arslan),
                )
                ],),
            ),
            Expanded(
                flex: 85,
                child:  Container(
                  width: width*.9,
                  decoration: BoxDecoration(
                      color: Appcolor.lightorange,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft:  Radius.circular(20),
                        bottomRight: Radius.circular(20),
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
                )),
          ],),
      ),
    );
  }
}
