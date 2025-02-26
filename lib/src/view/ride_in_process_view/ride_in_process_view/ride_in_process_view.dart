
import 'package:flutter/cupertino.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';


class RideInProcessView extends StatefulWidget {

  const RideInProcessView({super.key});

  @override
  State<RideInProcessView> createState() => _RideInProcessViewState();
}

class _RideInProcessViewState extends State<RideInProcessView> {
  late GoogleMapController mapController;
  final LatLng _initialPosition=  LatLng(37.7749, -122.4194);
  int select=0;

  @override
  void initState()
  {
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
      Navigator.push(context, CupertinoPageRoute(builder: (context)=>RideInWayView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        children: [
          ///===============================>>Container For maps
          Container(
            height:height*.46,
            width: width*1,
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
          ///===============================>>Container ride
          Padding(
            padding: EdgeInsets.only(top: height*.42),
            child: Container(
              height:height*1,
              width: width*1,
              decoration: BoxDecoration(
                  color:Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  )
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: width*.035,vertical: height*.015),
                child: SingleChildScrollView(
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ///===============================>> Row For Driver arrived
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BoldText(text: 'Driver arrived',fontSize: 16,color: Appcolor.green),
                            SizedBox(width: width*.02,),
                            Container(
                              height: height*.04,
                              width: width*.045,
                              decoration: BoxDecoration(
                                  color: Appcolor.green,
                                  shape: BoxShape.circle
                              ),
                              child: Center(child: Icon(Icons.check,size: width*.035,color: Theme.of(context).colorScheme.background)),
                            )
                          ],
                        ),
                        SizedBox(height: height*.01,),
                        CustomText(
                          text: 'Your driver is here and ready to take you to your',
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        CustomText(
                          text: 'destination.',
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        ///===============================>> car detail
                        CarDetailContainer(
                            image: Appimages.soloCar,
                            name: 'ABC-123',
                            carNumber: 'LN=27223',
                            price: '75'
                        ),
                        ///===============================>> text for driver detail
                        Row(
                          children: [
                            CustomText(
                              text: 'Driver Details',
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ],
                        ),
                        ///===============================>> Row For profile
                        ProfileRow(
                            image: Appimages.arslan,
                            name: 'John Doe',
                            ratting: '5.0',
                            views: '45'
                        ),
                        ///===============================>> Row For Buttons
                        Row(children: [
                          Expanded(
                              child: CustomButton(
                                onPressed:(){},
                                text: 'Call Driver',
                                color: Theme.of(context).colorScheme.background,
                                fontColor: Theme.of(context).colorScheme.secondary,
                              )),
                          SizedBox(width: width*.02,),
                          Expanded(
                              child: CustomButton(
                                onPressed:(){
                                  Navigator.push(context, CupertinoPageRoute(builder: (context)=>ChatView()));
                                },
                                text: 'Message Driver',
                                color: Theme.of(context).colorScheme.primary,
                                borderColor: Theme.of(context).colorScheme.primary,
                              )),
                        ],),
                        ///===============================>> Button For Cancel Ride
                        CustomButton(
                          onPressed:(){
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context, StateSetter setState) {
                                    return AlertDialog(
                                      backgroundColor: Theme.of(context).colorScheme.background,
                                      title: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            BoldText(
                                              text: 'Cancel Ride',
                                              fontSize: 18,
                                              color: Theme.of(context).colorScheme.secondary,
                                            ),
                                            SizedBox(height: height * 0.02),
                                            CancelRideRow(
                                              onTap: () {
                                                select = 1;
                                                setState(() {});
                                              },
                                              text: 'The driver asked me to cancel',
                                              backColor: select == 1
                                                  ? Theme.of(context).colorScheme.primary
                                                  : Theme.of(context).colorScheme.background,
                                              borderColor: select == 1
                                                  ? Theme.of(context).colorScheme.primary
                                                  : Colors.grey,
                                              fontColor: select == 1
                                                  ? Theme.of(context).colorScheme.primary
                                                  : Theme.of(context).colorScheme.secondary,
                                            ),
                                            CancelRideRow(
                                              onTap: () {
                                                select = 2;
                                                setState(() {});
                                              },
                                              text: 'I found an alternative',
                                              backColor: select == 2
                                                  ? Theme.of(context).colorScheme.primary
                                                  : Theme.of(context).colorScheme.background,
                                              borderColor: select == 2
                                                  ? Theme.of(context).colorScheme.primary
                                                  : Colors.grey,
                                              fontColor: select == 2
                                                  ? Theme.of(context).colorScheme.primary
                                                  : Theme.of(context).colorScheme.secondary,
                                            ),
                                            CancelRideRow(
                                              onTap: () {
                                                select = 3;
                                                setState(() {});
                                              },
                                              text: "I don't need a ride anymore",
                                              backColor: select == 3
                                                  ? Theme.of(context).colorScheme.primary
                                                  : Theme.of(context).colorScheme.background,
                                              borderColor: select == 3
                                                  ? Theme.of(context).colorScheme.primary
                                                  : Colors.grey,
                                              fontColor: select == 3
                                                  ? Theme.of(context).colorScheme.primary
                                                  : Theme.of(context).colorScheme.secondary,
                                            ),
                                            CancelRideRow(
                                              onTap: () {
                                                select = 4;
                                                setState(() {});
                                              },
                                              text: 'The driver is taking too long',
                                              backColor: select == 4
                                                  ? Theme.of(context).colorScheme.primary
                                                  : Theme.of(context).colorScheme.background,
                                              borderColor: select == 4
                                                  ? Theme.of(context).colorScheme.primary
                                                  : Colors.grey,
                                              fontColor: select == 4
                                                  ? Theme.of(context).colorScheme.primary
                                                  : Theme.of(context).colorScheme.secondary,
                                            ),
                                            CancelRideRow(
                                              onTap: () {
                                                select = 5;
                                                setState(() {});
                                              },
                                              text: 'Reason not listed',
                                              backColor: select == 5
                                                  ? Theme.of(context).colorScheme.primary
                                                  : Theme.of(context).colorScheme.background,
                                              borderColor: select == 5
                                                  ? Theme.of(context).colorScheme.primary
                                                  : Colors.grey,
                                              fontColor: select == 5
                                                  ? Theme.of(context).colorScheme.primary
                                                  : Theme.of(context).colorScheme.secondary,
                                            ),
                                            SizedBox(height: height*.02,),
                                            Row(children: [
                                              Expanded(child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  minimumSize: Size(width * 0.8, height * 0.06),
                                                  backgroundColor: Theme.of(context).colorScheme.background,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                    side: BorderSide(color: Appcolor.grey),
                                                  ),
                                                ),
                                                child: CustomText(
                                                  text: 'Close',
                                                  color: Theme.of(context).colorScheme.secondary,
                                                ),
                                              )),
                                              SizedBox(width: width*.03),
                                              Expanded(child: ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                  minimumSize: Size(width * 0.8, height * 0.06),
                                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                    side: BorderSide(color: Appcolor.yellow),
                                                  ),
                                                ),
                                                child: CustomText(
                                                  text: 'Cancel Ride',
                                                  color: Colors.white,
                                                ),
                                              )),
                                            ],)
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          text: 'Cancel Ride',
                          color: Theme.of(context).colorScheme.background,
                          fontColor: Colors.red,
                        ),

                      ],)
                ),
              ),
            ),
          ),
          ///===============================>> Positioned used for back button
          Positioned(
              left: width*.05,top: height*.05,
              child: BackButtonCustom()),
        ],
      ),
    );
  }
}
