import 'package:flutter/cupertino.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';



class FindDriverView extends StatefulWidget {
  String image;
  String carType;
   FindDriverView({super.key,required this.image,required this.carType});

  @override
  State<FindDriverView> createState() => _FindDriverViewState();
}

class _FindDriverViewState extends State<FindDriverView> {
  int  select=0;
  late GoogleMapController mapController;
  final LatLng _initialPosition=  LatLng(37.7749, 37.7749,);

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(children: [

        //================================>>1st container for maps
        Container(
          height:height*.65,
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
        //================================>>2nd container for select car and Confirm Button
        Padding(
          padding:  EdgeInsets.only(top: height*.61),
          child: Container(
            height:height*1,
            width: width*1,
           decoration: BoxDecoration(
             color: Theme.of(context).colorScheme.background,
             borderRadius: BorderRadius.only(
               topLeft: Radius.circular(20),
               topRight: Radius.circular(20),
             )
           ),
            child:  SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: width*.02,vertical: height*.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BoldText(
                      text: 'Select a way to travel',
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    //===================================>>>Row for select car
                    ConfirmCarRow(
                      ontap: (){
                        select=1;
                        setState(() {});
                      },
                      image: widget.image,
                      carType: widget.carType,
                      duration: '4 min away',
                      price: '70 - \$80',
                      fixedORMetered: 'Fixed',
                      backColor: select==1?Theme.of(context).colorScheme.primary.withOpacity(0.2):Theme.of(context).colorScheme.background,
                      borderColor: select==1?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.background,
                    ),
                    ConfirmCarRow(
                      ontap: (){
                        select=2;
                        setState(() {});
                      },
                      image: widget.image,
                      carType: widget.carType,
                      duration: '10 min away',
                      price: '70',
                      fixedORMetered: 'Metered',
                      backColor: select==2?Theme.of(context).colorScheme.primary.withOpacity(0.2):Theme.of(context).colorScheme.background,
                      borderColor: select==2?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.background,
                    ),
                    //======================================>>>Confirm Button
                    CustomButton(
                        onPressed: select!=0?()
                        {
                         Navigator.push(context, CupertinoPageRoute(builder: (context)=>ScheduleRideView()));
                        }:
                        //: () {}, // Empty function for disabled state
                            (){},
                        text: 'Confirm',
                        color: select !=0
                            ?Theme.of(context).colorScheme.primary
                            :Colors.grey,
                        borderColor: select !=0? Theme.of(context).colorScheme.primary:Colors.grey
                    )
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












//change

// class FindDriverView extends StatefulWidget {
//   String image;
//   String carType;
//   // String duration;
//   // String fixedORMetered;
//   // String price;
//    FindDriverView({super.key,
//      required this.image,
//      required this.carType,
//      // required this.duration,
//      // required this.price,
//      // required this.fixedORMetered,
//    });
//
//   @override
//   State<FindDriverView> createState() => _FindDriverViewState();
// }
//
// class _FindDriverViewState extends State<FindDriverView> {
//
//   int select=0;
//   late GoogleMapController mapController;
//
//   final LatLng _initialPosition=  LatLng(37.7749, -122.4194);
//
//   @override
//   Widget build(BuildContext context) {
//     final width=MediaQuery.sizeOf(context).width;
//     final height=MediaQuery.sizeOf(context).height;
//     return Scaffold(
//       backgroundColor: Colors.grey,
//       body: Column(children: [
//         //===========================================>>>1st Expended for maps
//         Expanded(
//           flex: 60,
//             child: Stack(
//               children: [
//                 GoogleMap(
//                   onMapCreated: (GoogleMapController controller) {
//                      mapController = controller;
//                   },
//                   initialCameraPosition: CameraPosition(
//                     target: _initialPosition,
//                     zoom: 12.0,
//                   ),
//                   zoomControlsEnabled: false, // Hides zoom controls
//                   myLocationEnabled: true,   // Enables user's location
//                 ),
//                 Positioned(
//                   left: width*.06,top: height*.06,
//                   child: BackButtonCustom()
//                 )
//               ],
//             )),
//         //=========================   ===>>>2nd Expended for select car and Confirm Button
//         Expanded(
//           flex: 40,
//             child: Container(
//              width: width*1,
//             decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.background,
//               borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(20),
//                 topLeft: Radius.circular(20),
//               )
//             ),
//               child: Padding(
//                 padding:  EdgeInsets.symmetric(horizontal: width*.03,vertical: height*.02),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                        CustomText(
//                       text: 'Select a way to travel',
//                       fontSize: 16,
//                       color: Theme.of(context).colorScheme.secondary,
//                     ),
//                       SizedBox(height: height*.01,),
//                       //===================================>>>Row for select car
//                       ConfirmCarRow(
//                         ontap: (){
//                           select=1;
//                           setState(() {});
//                         },
//                           image: widget.image,
//                           carType: widget.carType,
//                           duration: '4 min away',
//                           price: '70 - \$80',
//                         fixedORMetered: 'Metered',
//                         backColor: select==1?Theme.of(context).colorScheme.primary.withOpacity(0.2):Theme.of(context).colorScheme.background,
//                         borderColor: select==1?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.background,
//                       ),
//                       ConfirmCarRow(
//                         ontap: (){
//                           select=2;
//                           setState(() {});
//                         },
//                           image: widget.image,
//                           carType: widget.carType,
//                           duration: '10 min away',
//                           price: '70',
//                         fixedORMetered: 'Fixed',
//                         backColor: select==2?Theme.of(context).colorScheme.primary.withOpacity(0.2):Theme.of(context).colorScheme.background,
//                         borderColor: select==2?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.background,
//                       ),
//                       //======================================>>>Confirm Button
//                       CustomButton(
//                         onPressed: select!=0
//                           ?()
//                           {  }:
//                         //: () {}, // Empty function for disabled state
//                         (){},
//                           text: 'Confirm',
//                         color: select !=0
//                           ?Theme.of(context).colorScheme.primary
//                           :Colors.grey,
//                         borderColor: select !=0? Theme.of(context).colorScheme.primary:Colors.grey
//                           )
//                   ],),
//                 ),
//               ),
//         )),
//       ],),
//     );
//   }
// }
//
//
//
