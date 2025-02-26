import 'package:flutter/cupertino.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';

class SelectDestinationsView extends StatefulWidget {
  SelectDestinationsView({super.key});

  @override
  State<SelectDestinationsView> createState() => _SelectDestinationsViewState();
}

class _SelectDestinationsViewState extends State<SelectDestinationsView> {
TextEditingController destinationController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding:EdgeInsets.symmetric(vertical: height*.06,horizontal: width*.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoldText(text: 'Book a Ride',fontSize: 18,color: Theme.of(context).colorScheme.secondary,),
                SizedBox(height: height*.015),
                CustomTextFormField(hintText: 'Enter your destination', controller: destinationController),
                Center(child: BoldText(text: 'or',fontSize: 18,color: Theme.of(context).colorScheme.secondary,)),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height*.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.map,color: Theme.of(context).colorScheme.secondary,),
                      TextButton(
                        onPressed: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context)=>SelectFromMapView()));
                        },
                        child:BoldText(text: 'Select From Map',fontSize: 14,color: Theme.of(context).colorScheme.secondary,)
                      )
                    ],),
                ),
                CustomText(text: 'Suggested Locations',fontSize: 16,color: Theme.of(context).colorScheme.secondary,),
                SizedBox(height: height*.01,),
                SuggestedLocation(
                    image: Appimages.location,
                    location: 'Islamabad Shopping Mall'
                ),
                SuggestedLocation(
                    image: Appimages.planeIcon,
                    location: 'Islamabad National Airport Terminal 1'
                ),
                SuggestedLocation(
                    image: Appimages.matro,
                    location: 'Metro Bus Station'
                ),
                SuggestedLocation(
                    image: Appimages.railWay,
                    location: 'Islamabad Railway Station'
                ),
                SuggestedLocation(
                    image: Appimages.location,
                    location: 'City Park'
                ),
                Padding(
                  padding:  EdgeInsets.only(top: height*.17),
                  child: CustomButton(
                    onPressed: (){
                      Navigator.push(context, CupertinoPageRoute(builder: (context)=>ConfirmRideView()));
                    },
                    text: 'Confirm Destination',
                    color: Theme.of(context).colorScheme.primary,
                    borderColor: Theme.of(context).colorScheme.primary,
                  ),
                )
              ],),
          ),
        ],)
      ),
    );
  }
}
