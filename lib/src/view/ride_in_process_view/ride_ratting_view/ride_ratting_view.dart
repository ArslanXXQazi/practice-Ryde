import 'package:flutter/cupertino.dart';
import 'package:practice_ryde/src/controllers/components/star_button.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';

import '../../../controllers/components/rich_text_form_field.dart';


class RideRattingView extends StatefulWidget {
  const RideRattingView({super.key});

  @override
  State<RideRattingView> createState() => _RideRattingViewState();
}

class _RideRattingViewState extends State<RideRattingView> {
  late GoogleMapController mapController;
  final LatLng _initialPosition = LatLng(37.7749, -122.4194);
  TextEditingController feedBackController=TextEditingController();
  int select = 0;
  int check =0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Stack(
        children: [
          ///===============================>> Container For Maps
          Container(
            height: height * .4,
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

          ///===============================>> Container Rating
          Padding(
            padding: EdgeInsets.only(top: height * .35),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BoldText(
                              text: 'Ride complete',
                              fontSize: 16,
                              color: Appcolor.green),
                          SizedBox(width: width * .02),
                          Container(
                            height: height * .04,
                            width: width * .045,
                            decoration: BoxDecoration(
                                color: Appcolor.green, shape: BoxShape.circle),
                            child: Center(
                              child: Icon(Icons.check,
                                  size: width * .035,
                                  color:
                                  Theme.of(context).colorScheme.background),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * .01),
                      BoldText(
                        text: 'Rate your driver. Your feedback will help us',
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      BoldText(
                        text: 'improve your future trips with us.',
                        fontSize: 16,
                        color:Theme.of(context).colorScheme.secondary,
                      ),
                      SizedBox(height: height*.02,),
                      ///===============================>> Row For Text Your Ratting
                      Row(
                        children: [
                          CustomText(
                            text: 'Your Rating',
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      ///===============================>> row for stars
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                              (index) => StarButton(
                            onTap: () {
                              select = index + 1;
                              setState(() {});
                            },
                            color: select > index ? Appcolor.yellow : Colors.grey,
                          ),
                        ),
                      ),
                      ///===============================>> Row Feedback
                      Row(
                        children: [
                          CustomText(
                            text: 'Your Feedback (optional)',
                            fontSize: 16,
                            color:Colors.grey,
                          ),
                        ],
                      ),
                      ///===============================>> Rich Text Field
                     RichTextFormField(controller: feedBackController, hintText: ''),
                      SizedBox(height: height*.01,),
                      ///===============================>> Row For Add Driver as Favourite
                      Row(children: [
                        GestureDetector(
                          onTap: (){
                            check = check == 1 ? 0 : 1;
                            setState(() {});
                          },
                          child: Container(
                            height: height*.025,
                            width: width*.055,
                            decoration: BoxDecoration(
                              color: check==1?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: check==1?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.primary),
                            ),
                            child: Icon(
                              check==1?Icons.check :null,size: width*.04,color: check==1?Theme.of(context).colorScheme.background:Theme.of(context).colorScheme.background,
                            ),
                          ),
                        ),
                        SizedBox(width: width*.01,),
                        CustomText(
                          text: ' Add driver as favourite',
                          fontSize: 16,
                          color:Theme.of(context).colorScheme.secondary,
                        ),

                      ],),

                      ///===============================>> Submit Button
                      CustomButton(
                        onPressed: ()
                        {
                          Navigator.push(context, CupertinoPageRoute(builder: (context)=>NavBarView()));
                        },
                        text: 'Submit',
                        color: Theme.of(context).colorScheme.primary,
                        borderColor: Theme.of(context).colorScheme.primary,
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
