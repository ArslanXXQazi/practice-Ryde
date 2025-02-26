import 'package:flutter/cupertino.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';

class SelectFromMapView extends StatefulWidget {
  const SelectFromMapView({super.key});

  @override
  State<SelectFromMapView> createState() => _SelectFromMapViewState();
}

class _SelectFromMapViewState extends State<SelectFromMapView> {

  late GoogleMapController mapController;
  final LatLng _initialPosition=  LatLng(37.7749, -122.4194);

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          //================================>>1st container for maps
        Container(
          height: height*.73,
          width: width*1,
          color: Appcolor.grey,
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
          //================================>>2nd container for location and confirm button
        Padding(
          padding:  EdgeInsets.only(top: height*.70),
          child: Container(
            height: height*1,
            width: width*1,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: width*.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                BoldText(text: 'Location',fontSize: 16,color:Theme.of(context).colorScheme.secondary,),
                SizedBox(height: height*.02,),
                SuggestedLocation(image: Appimages.location, location: 'Islamabad Shopping Mall'),
                CustomButton(
                    onPressed: (){
                      Navigator.push(context,  CupertinoPageRoute(builder: (context)=>ConfirmRideView()));
                    },
                    text: "Confirm Destination ",
                    borderColor: Theme.of(context).colorScheme.primary,
                    color: Theme.of(context).colorScheme.primary,
                )
              ],),
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
