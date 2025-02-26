
import 'package:flutter/cupertino.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';
import 'package:practice_ryde/src/view/navbar_views/homenav_view/select_destination_view/select_destinations_view.dart';

class BookNowContainer extends StatelessWidget {
  String text;
  String image;
   BookNowContainer({super.key,
     required this.text,
     required this.image,
   });

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width*.003),
      child: Container(
        height: height*.16,
        width: width*1,
        decoration: BoxDecoration(
          color: Appcolor.yellow,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: height*.00,horizontal: width*.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: height*.015),
                child: BoldText(text: text,color: Colors.white,fontSize: 16,),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(image: AssetImage(image)),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, CupertinoPageRoute(builder: (context)=>SelectDestinationsView()));
                      },
                      child: CustomText(text: 'Book Now',color: Appcolor.yellow,fontWeight: FontWeight.bold,fontSize: 14,)
                  )
                ],
              ),
            ],),
        ),
      ),
    );
  }
}
