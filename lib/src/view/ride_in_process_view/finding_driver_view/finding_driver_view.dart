import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';


class FindingDriverView extends StatefulWidget {
  const FindingDriverView({super.key});

  @override
  State<FindingDriverView> createState() => _FindingDriverViewState();
}

class _FindingDriverViewState extends State<FindingDriverView>
    with SingleTickerProviderStateMixin {

  late GoogleMapController mapController;
  final LatLng _initialPosition = LatLng(37.7749, -122.4194);
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the Animation Controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    Future.delayed(Duration(seconds: 4),(){
      Navigator.push(context, CupertinoPageRoute(builder: (context)=>DriverOnWayView()));
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        children: [
          ///===============================>> Container For Maps
          Container(
            height: height * .63,
            width: width * 1,
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 12.0,
              ),
              zoomControlsEnabled: false,
              myLocationEnabled: true,
            ),
          ),

          ///===============================>> Container Searching
          Padding(
            padding: EdgeInsets.only(top: height * .6),
            child: Container(
              height: height * 1,
              width: width * 1,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * .035, vertical: height * .03),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ///===============================>> Row for Complete Ride
                      BoldText(
                          text: 'Finding your driver. Hang tight!',
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.secondary),
                      SizedBox(height: height * .02),
                      ///===============================>> Container for searching
                      Container(
                        height: height * .2,
                        width: width * 1,
                        child: Center(
                          child: Stack(
                            children: [
                              Container(
                                height: height * .1,
                                width: width * .7,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Appcolor.grey)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: height*.075,
                                        width: width*.15,
                                       decoration: BoxDecoration(
                                         color:  Colors.grey.shade100,
                                         borderRadius: BorderRadius.circular(10),
                                       ),
                                      ),
                                      SizedBox(width: width*.02,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: height*.03,
                                            width: width*.32,
                                           decoration: BoxDecoration(
                                             color:  Colors.grey.shade100,
                                             borderRadius: BorderRadius.circular(10),
                                           ),

                                          ),
                                          SizedBox(height: height*.01,),
                                          Container(
                                            height: height*.03,
                                            width: width*.4,
                                           decoration: BoxDecoration(
                                             color:  Colors.grey.shade100,
                                             borderRadius: BorderRadius.circular(10),
                                           ),

                                          ),
                                        ],
                                      ),

                                    ],
                                  )
                                ],),
                              ),
                              Positioned(
                                left: width*.57,top: height*.01,
                                child: ScaleTransition(
                                  scale: _animation,
                                  child: ImageIcon(AssetImage(Appimages.search,),size: width*.12,),
                                  // child: Icon(
                                  //   Icons.search_rounded,
                                  //   size: 50,
                                  //   color: Colors.grey,
                                  // ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ///===============================>> Cancel Ride Button
                      CustomButton(
                        onPressed: () {},
                        text: 'Cancel Ride',
                        color: Theme.of(context).colorScheme.background,
                        borderColor: Theme.of(context).colorScheme.tertiary,
                        fontColor: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          ///===============================>> Positioned Used Back Button
          Positioned(
            left: width * .05,
            top: height * .05,
            child: BackButtonCustom(),
          ),
        ],
      ),
    );
  }
}

