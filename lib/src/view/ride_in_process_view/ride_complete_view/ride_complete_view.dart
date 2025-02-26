

import 'package:flutter/cupertino.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';


class RideCompleteView extends StatefulWidget {
  const RideCompleteView({super.key});

  @override
  State<RideCompleteView> createState() => _RideCompleteViewState();
}

class _RideCompleteViewState extends State<RideCompleteView> {
  late GoogleMapController mapController;
  final LatLng _initialPosition=  LatLng(37.7749, -122.4194);

  @override
  void initState()
  {
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
      Navigator.push(context, CupertinoPageRoute(builder: (context)=>RideRattingView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Scaffold(
       body: Stack(children: [
         ///===============================>>Container For maps
         Container(
           height:height*.68,
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
           padding: EdgeInsets.only(top: height*.65),
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
               padding:  EdgeInsets.symmetric(horizontal: width*.035,vertical: height*.03),
               child: SingleChildScrollView(
                   child:Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       ///===============================>>Text For destination reached
                       BoldText(text: 'Destination reached',fontSize: 16,color: Appcolor.green),
                       SizedBox(height: height*.01,),
                       CustomText(
                         text: 'Waiting for driver to finish the ride.',
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
                     ],)
               ),
             ),
           ),
         ),
         ///===============================>> Positioned used for back button
         Positioned(
             left: width*.05,top: height*.05,
             child: BackButtonCustom()),
       ],),
    );
  }
}
