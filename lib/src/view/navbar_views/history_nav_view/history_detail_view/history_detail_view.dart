
import 'package:practice_ryde/src/controllers/constants/linker.dart';

import '../../../../controllers/components/dialog_box_row.dart';

class HistoryDetailView extends StatefulWidget {

  String image;
  String carType;
  String location;
  String date;
  String price;
  VoidCallback ontap;

  HistoryDetailView({super.key,

    required this.image,
    required this.carType,
    required this.location,
    required this.date,
    required this.price,
    required this.ontap


  });

  @override
  State<HistoryDetailView> createState() => _HistoryDetailViewState();
}

class _HistoryDetailViewState extends State<HistoryDetailView> {

  late GoogleMapController mapController;
  final LatLng _initialPosition=  LatLng(37.7749, -122.4194);

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back,color: Theme.of(context).colorScheme.secondary,)),
        title: BoldText(text: 'Back to Ride History',fontSize: 16,color:Theme.of(context).colorScheme.secondary,),
        actions:
        [
          Padding(
            padding: EdgeInsets.only(right:width*.02),
            child: InkWell(
                onTap: ()
                {
                  showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        backgroundColor: Theme.of(context).colorScheme.background,
                        title:SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BoldText(text: 'Get Help',fontSize: 18,color: Theme.of(context).colorScheme.secondary,),
                              SizedBox(height: height*.02,),
                              DialogBoxRow(
                                  onTap: (){},
                                  image: Appimages.chaticon,
                                  text: 'Contact Support'
                              ),
                              DialogBoxRow(
                                  onTap: (){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context){
                                        return AlertDialog(
                                          backgroundColor: Theme.of(context).colorScheme.background,
                                          title:SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                BoldText(text: 'Report an Error',fontSize: 18,color: Theme.of(context).colorScheme.secondary,),
                                                SizedBox(height: height*.02,),
                                                CustomText(text: 'Please provide a detailed description of any issues or errors you have encountered.',fontSize: 14,color: Theme.of(context).colorScheme.secondary,),
                                                SizedBox(height: height*.02,),
                                                TextField(
                                                  style: TextStyle(color:Theme.of(context).colorScheme.secondary,fontFamily: 'satoshi'),
                                                  maxLines: 7,
                                                  decoration: InputDecoration(
                                                    hintText: "Describe the issue...",
                                                    hintStyle: TextStyle(fontFamily: 'satoshi',color: Theme.of(context).colorScheme.secondary),
                                                    border: InputBorder.none,
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide: BorderSide(color: Appcolor.grey),
                                                    ),
                                                    focusedBorder:OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide: BorderSide(color: Appcolor.yellow),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: height*.02,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                        onPressed: (){Navigator.pop(context);},
                                                        style: ElevatedButton.styleFrom(
                                                            minimumSize: Size(width*.3, height*.06),
                                                            backgroundColor: Theme.of(context).colorScheme.background,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10),
                                                              side: BorderSide(color: Appcolor.grey),
                                                            )
                                                        ),
                                                        child:CustomText(text: 'Cancel',color: Theme.of(context).colorScheme.secondary,)
                                                    ),
                                                    SizedBox(width: width*.02,),
                                                    ElevatedButton(
                                                        onPressed: (){},
                                                        style: ElevatedButton.styleFrom(
                                                            minimumSize: Size(width*.3, height*.06),
                                                            backgroundColor: Theme.of(context).colorScheme.primary,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(10),
                                                              side: BorderSide(color: Appcolor.yellow),
                                                            )
                                                        ),
                                                        child:CustomText(text: 'Submit',color: Colors.white)
                                                    ),
                                                  ],),

                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  image: Appimages.errorIcon,
                                  text: 'Report an Error'
                              ),
                              DialogBoxRow(
                                  onTap: (){},
                                  image: Appimages.callicon,
                                  text: 'Call Driver'
                              ),
                              SizedBox(height: height*.02,),
                              ElevatedButton(
                                  onPressed: (){Navigator.pop(context);},
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(width*.8, height*.06),
                                      backgroundColor: Theme.of(context).colorScheme.background,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(color: Appcolor.grey),
                                      )
                                  ),
                                  child:CustomText(text: 'Close',color: Theme.of(context).colorScheme.secondary,)
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: ImageIcon(AssetImage(Appimages.chaticon),color: Theme.of(context).colorScheme.secondary,size: width*.08,)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*.03),
        child: SingleChildScrollView(
          child: Column(children: [
            //=====================>>Container for car History
            SizedBox(height: height*.02),
            Container(
                height: height*.11,
                width: width*1,
                color: Theme.of(context).colorScheme.background,
                child: Row(children: [
                  Expanded(
                      flex:30,
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
                              Image(image: AssetImage(widget.image)),
                              CustomText(text: widget.carType,color:Theme.of(context).colorScheme.secondary,)
                            ],),
                          )
                      )),
                  Expanded(
                      flex:70,
                      child: Container(
                        child: Padding(
                          padding:  EdgeInsets.only(left: width*.03),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BoldText(text: widget.location,fontSize: 16,color: Theme.of(context).colorScheme.secondary,),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: height*.01),
                                child: CustomText(text: widget.date,fontSize: 12,color: Theme.of(context).colorScheme.secondary,),
                              ),
                              CustomText(text: '\$${widget.price}',fontSize: 16,color: Theme.of(context).colorScheme.primary,),
                            ],),
                        ),
                      )),
                ],)
            ),

            //=====================>>Container for pick up and Drop off
            Padding(
              padding: EdgeInsets.symmetric(vertical: height*.025),
              child: Container(
                height: height*.195,
                width: width*1,
                color: Theme.of(context).colorScheme.background,
                child: Row(
                  children: [
                    Expanded(
                        flex:10,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.location_on_rounded,color: Appcolor.yellow,size: 30,),
                              Image(image: AssetImage(Appimages.line2)),
                              Icon(Icons.location_on_rounded,color: Appcolor.yellow,size: 30,),

                            ],
                          ),
                        )),
                    Expanded(
                        flex: 80,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BoldText(text: "Pick Up",fontSize: 13,color: Theme.of(context).colorScheme.secondary),
                                  CustomText(text: 'Islamabad Shopping Mall',fontSize: 16,color: Theme.of(context).colorScheme.secondary),
                                  CustomText(text: '4:23 pm',fontSize: 13,color: Theme.of(context).colorScheme.secondary)
                                ],),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BoldText(text: "Drop Off",fontSize: 13,color: Theme.of(context).colorScheme.secondary),
                                  CustomText(text: 'Islamabad Shopping Mall',fontSize: 16,color: Theme.of(context).colorScheme.secondary),
                                  CustomText(text: '4:23 pm',fontSize: 13,color: Theme.of(context).colorScheme.secondary)
                                ],),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),

            //=====================>>Container for Maps
            Container(
              height: height*.2,
              width: width*1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                border: Border.all(color: Colors.grey),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 12.0,
                  ),
                  zoomControlsEnabled: false, // Hides zoom controls
                  myLocationEnabled: true,   // Enables user's location
                ),
              ),
            ),

            //=====================>>Container payment details
            SizedBox(height: height*.03),
            Container(
                height: height*.1,
                width: width*1,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width*.02),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(text: 'Fare',color: Theme.of(context).colorScheme.secondary),
                          BoldText(text: '\$54',color: Theme.of(context).colorScheme.secondary,fontSize: 16,),
                        ],),
                      SizedBox(height: height*.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(text: 'Payment Method',color: Theme.of(context).colorScheme.secondary),
                          BoldText(text: 'Cash',color: Theme.of(context).colorScheme.secondary,fontSize: 16,),
                        ],),
                    ],),
                )
            )
          ],),
        ),
      ),
    );
  }
}


