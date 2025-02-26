import 'package:practice_ryde/src/controllers/constants/linker.dart';
class TripsContainer extends StatelessWidget {

  String image;
  String location;
  String carType;
  String date;
  String price;
  VoidCallback? ontap;

   TripsContainer({super.key,
     required this.image,
     required this.location,
     required this.carType,
     required this.date,
     required this.price,
     this.ontap
   });

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: height*.012),
      child: GestureDetector(
        onTap: ontap,
       //  onTap: (){
       //    Navigator.push(context, CupertinoPageRoute(builder: (context)=>HistoryDetailView(image: image, carType: carType, location: location, date: date, price: price)));
       //  },
        child: Container(
            height: height*.11,
            width: width*1,
            color: Theme.of(context).colorScheme.background,
            child: Row(children: [
              Expanded(
                  flex:25,
                  child: Container(
                      child: Container(
                        height: height*.12,
                        width: width*1,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Appcolor.grey),
                        ),
                        child: Column(children: [
                          Image(image: AssetImage(image)),
                          CustomText(text: carType,color:Theme.of(context).colorScheme.secondary,)
                        ],),
                      )
                  )),
              Expanded(
                  flex:65,
                  child: Container(
                    child: Padding(
                      padding:  EdgeInsets.only(left: width*.03),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BoldText(text: location,fontSize: 16,color: Theme.of(context).colorScheme.secondary,),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: height*.01),
                            child: CustomText(text: date,fontSize: 12,color: Theme.of(context).colorScheme.secondary,),
                          ),
                          CustomText(text: '\$$price',fontSize: 16,color: Theme.of(context).colorScheme.primary,),
                        ],),
                    ),
                  )),
              Expanded(
                  flex:10,
                  child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: (){},
                              icon:Icon(Icons.arrow_forward_ios,color: Colors.grey,)),
                        ],)
                  )),
            ],)
        ),
      ),
    );
  }
}
