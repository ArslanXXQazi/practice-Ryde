
import 'package:flutter/cupertino.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';

import '../select_destination_view/select_destinations_view.dart';



class ConfirmRideView extends StatefulWidget {
  const ConfirmRideView({super.key});

  @override
  State<ConfirmRideView> createState() => _ConfirmRideViewState();
}

class _ConfirmRideViewState extends State<ConfirmRideView> {
   int select=0;
   int confirm=0;
  late GoogleMapController mapController;
  final LatLng _initialPosition=  LatLng(37.7749, -122.4194);

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(children: [
        //================================>>1st container for maps
        Container(
          height:height*.37,
          width: width*1,
          child: GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 14.0,
            ),
            zoomControlsEnabled: false, // Hides zoom controls
            myLocationEnabled: true,   // Enables user's location
          ),
        ),
        //=====================================2nd container for Route
        Padding(
          padding: EdgeInsets.only(top: height*.31),
          child: Container(
            height:height*.7,
            width: width*1,
           decoration: BoxDecoration(
             color:Theme.of(context).colorScheme.background,
             borderRadius: BorderRadius.only(
               topRight: Radius.circular(20),
               topLeft: Radius.circular(20),
             )
           ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: width*.026),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height*.02,),
                    BoldText(text: 'Route',fontSize:16,color: Theme.of(context).colorScheme.secondary,),
                    //=====================================>>Container for location
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height*.01),
                      child: Container(
                        height: height*.153,
                        width: width*1,
                        color: Theme.of(context).colorScheme.background,
                        child: Row(
                          children: [
                            Expanded(
                                flex:10,
                                child: Container(
                                  child: Column(
                                    children: [
                                      Icon(Icons.location_on_rounded,color: Appcolor.yellow,size: 30,),
                                      Image(image: AssetImage(Appimages.line)),
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
                                          BoldText(text: "Form",fontSize: 16,color: Theme.of(context).colorScheme.secondary),
                                          Row(children: [
                                            CustomText(text: 'Your location',fontSize: 16,color: Theme.of(context).colorScheme.secondary),
                                            SizedBox(width: width*.05,),
                                            Icon(Icons.edit_outlined,color: Theme.of(context).colorScheme.primary,),
                                            SizedBox(width: width*.02),
                                            GestureDetector(
                                                onTap: (){
                                                  Navigator.push(context,  CupertinoPageRoute(builder: (context)=>SelectDestinationsView()));
                                                },
                                                child: CustomText(text: 'Edit',color: Theme.of(context).colorScheme.primary,)),
                                          ],)
                                        ],),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          BoldText(text: "To",fontSize: 16,color: Theme.of(context).colorScheme.secondary),
                                          Row(children: [
                                            CustomText(text: 'Islamabad Shopping Mall',fontSize: 16,color: Theme.of(context).colorScheme.secondary),
                                            SizedBox(width: width*.05,),
                                            Icon(Icons.edit_outlined,color: Theme.of(context).colorScheme.primary,),
                                            SizedBox(width: width*.02),
                                            GestureDetector(
                                                onTap: (){
                                                  Navigator.push(context,  CupertinoPageRoute(builder: (context)=>SelectDestinationsView()));
                                                },
                                                child: CustomText(text: 'Edit',color: Theme.of(context).colorScheme.primary,)),
                                          ],)
                                        ],),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    //=====================================>>Row for Second Stop
                    Row(children: [
                      BoldText(text: '+',color: Theme.of(context).colorScheme.secondary,fontSize: 24,),
                      TextButton(
                          onPressed: (){},
                          child:BoldText(text: 'Add Second Stop',color: Theme.of(context).colorScheme.secondary,fontSize: 20,),
                      )
                    ],),
                    SizedBox(height: height*.01),
                    //=====================================>>Text for Taxi
                    BoldText(text: 'Taxi Type',fontSize:16,color: Theme.of(context).colorScheme.secondary,),
                    //=====================================>>Row for select taxi type
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CarSelectContainer(
                          ontap: (){
                            select=1;
                            setState(() =>());
                          },
                          borderColor: select==1?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.tertiary,
                          color: select==1?Theme.of(context).colorScheme.primary.withOpacity(0.2):Theme.of(context).colorScheme.background,
                          image: Appimages.soloCar,
                          carTape: 'Solo (1-4)',

                        ),
                        CarSelectContainer(
                            ontap: (){
                              select=2;
                              setState(()=>());
                            },
                            borderColor: select==2?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.tertiary,
                            color: select==2?Theme.of(context).colorScheme.primary.withOpacity(0.2):Theme.of(context).colorScheme.background,
                            image:Appimages.groupCar,
                            carTape: 'Group (1-6)'),
                        CarSelectContainer(
                            ontap: (){
                              select=3;
                              setState(()=>());

                            },
                            borderColor: select==3?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.tertiary,
                            color: select==3?Theme.of(context).colorScheme.primary.withOpacity(0.2):Theme.of(context).colorScheme.background,
                            image:Appimages.partyCar,
                            carTape: 'Party (1-8)'),
                      ],),
                    //=====================================>>Text for Payment
                    BoldText(text: 'Payment Method',fontSize:16,color: Theme.of(context).colorScheme.secondary,),
                    //=====================================>>Payment Rows
                    PaymentRow(
                        onTap: (){
                          confirm=1;
                          setState(() {});
                        },
                        backColor: confirm==1?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.background,
                        borderColor:confirm==1?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.tertiary,
                        iconColor:confirm==1?Theme.of(context).colorScheme.background:Theme.of(context).colorScheme.background,
                        textcolor:confirm==1?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.secondary,
                        text: "Pay to Driver (Cash or Card)"),
                    PaymentRow(
                        onTap: (){
                          confirm=2;
                          setState(() {});
                        },
                        backColor: confirm==2?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.background,
                        borderColor: confirm==2?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.tertiary,
                        iconColor:confirm==2?Theme.of(context).colorScheme.background:Theme.of(context).colorScheme.background,
                        textcolor:confirm==2?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.secondary,
                        text: "Apple Pay"),
                    //=====================================>>Row For Buttons
                    Row(children: [
                      Expanded(child:
                      CustomButton(
                        onPressed: ()
                        {
                          if (select != 0 && confirm !=0)
                          {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => FindDriverView(
                                  image: select == 1
                                      ? Appimages.soloCar
                                      : select == 2
                                      ? Appimages.groupCar
                                      : Appimages.partyCar, // Pass selected car image
                                  carType: select == 1
                                      ? 'Solo (1-4)'
                                      : select == 2
                                      ? 'Group (1-6)'
                                      : 'Party (1-8)', // Pass selected car type
                                ),
                              ),
                            );
                          }
                          else
                          {
                            final snackBar= SnackBar(
                              content: CustomText(text: 'Please select car type and payment method first!',fontSize: 16,color: Colors.red),
                              backgroundColor:Colors.white,
                              behavior: SnackBarBehavior.floating,
                              duration: Duration(seconds: 3),
                              action: SnackBarAction(
                                label: 'Dismiss',
                                onPressed: (){ScaffoldMessenger.of(context).hideCurrentSnackBar();},
                                backgroundColor: Colors.black,
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        },
                        text: 'Schedule for Later',
                        color: Theme.of(context).colorScheme.background,
                        fontColor: Theme.of(context).colorScheme.secondary,
                      ),
                      ),
                      SizedBox(width: width*.03,),
                      Expanded(child:
                      CustomButton(
                        onPressed: ()
                        {
                          if (select != 0 && confirm !=0)
                          {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => FindDriverView(
                                  image: select == 1
                                      ? Appimages.soloCar
                                      : select == 2
                                      ? Appimages.groupCar
                                      : Appimages.partyCar, // Pass selected car image
                                  carType: select == 1
                                      ? 'Solo (1-4)'
                                      : select == 2
                                      ? 'Group (1-6)'
                                      : 'Party (1-8)', // Pass selected car type
                                ),
                              ),
                            );
                          }
                          else
                          {
                            final snackBar= SnackBar(
                              content: CustomText(text: 'Please select car type and payment method first!',fontSize: 16,color: Colors.red),
                              backgroundColor:Colors.white,
                              behavior: SnackBarBehavior.floating,
                              duration: Duration(seconds: 3),
                              action: SnackBarAction(
                                  label: 'Dismiss',
                                  onPressed: (){ScaffoldMessenger.of(context).hideCurrentSnackBar();},
                                  backgroundColor: Colors.black,
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        },
                        text: 'Find Drivers',
                        color: Theme.of(context).colorScheme.primary,
                        borderColor: Theme.of(context).colorScheme.primary,
                      ),
                      ),
                    ],)
                  ],),
              ),
            ),
          ),
        ),
        Positioned(
          left: width*.05,top: height*.05,
            child: BackButtonCustom()),
      ],),

    );
  }
}