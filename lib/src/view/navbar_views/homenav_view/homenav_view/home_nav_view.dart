import 'package:flutter/cupertino.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';

import '../select_destination_view/select_destinations_view.dart';


class HomeNavView extends StatefulWidget {
   HomeNavView({super.key});

  @override
  State<HomeNavView> createState() => _HomeNavViewState();
}

class _HomeNavViewState extends State<HomeNavView> {
  final PageController pageController=PageController();
  TextEditingController searchController=TextEditingController();
  int select=0;

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor:Theme.of(context).colorScheme.background,
      body: Padding(
        padding:  EdgeInsets.only(top: height*.06,left: width*.03,right: width*.03),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            //===================>>Row for name and good morning
               Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BoldText(text: 'Good Morning,',fontSize: 18,color: Theme.of(context).colorScheme.secondary,),
                SizedBox(width: width*.02,),
                CustomText(text: 'John',fontSize: 18,color: Appcolor.grey),
              ],
            ),
              //===================>>Container for book now
              Padding(
                padding: EdgeInsets.symmetric(vertical: height*.013),
                child: Stack(children: [
                  Container(
                    height: height*.16,
                    child: PageView(
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      children: [
                        BookNowContainer(
                            text: 'On-Time Pickups, Every Time',
                            image: Appimages.clock,
                        ),
                        BookNowContainer(
                          text: 'To the Airport with Ease!',
                          image: Appimages.plane,
                        ),
                        BookNowContainer(
                          text: 'On-Time Train Station Taxis!',
                          image: Appimages.trane,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                   top: height*.13,left: width*.42,
                    child: SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                      axisDirection: Axis.horizontal,
                      effect: JumpingDotEffect(
                        spacing: 10,
                        dotWidth:  8.0,
                        dotHeight:  8.0,
                        dotColor: Colors.white60,
                        activeDotColor: Colors.white,
                      ),

                    ),
                  )
                ],),
              ),
              //===================>> search text field
              CustomTextFormField(
                  hintText: 'Where would you like to go?',
                  controller: searchController,
                  suffixIcon: Icons.search,
              ),
              //===================>> Car select row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CarSelectContainer(
                      ontap: (){
                        select=1;
                        setState(()=>());
                        Navigator.push(context, CupertinoPageRoute(builder: (context)=>SelectDestinationsView()));
                      },
                      borderColor: select==1?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.tertiary,
                      color: select==1?Theme.of(context).colorScheme.primary.withOpacity(0.2):Theme.of(context).colorScheme.background,
                      image:Appimages.soloCar,
                      carTape: 'Solo (1-4)'),
                  CarSelectContainer(
                      ontap: (){
                        select=2;
                        setState(()=>());
                        Navigator.push(context, CupertinoPageRoute(builder: (context)=>SelectDestinationsView()));
                      },
                      borderColor: select==2?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.tertiary,
                      color: select==2?Theme.of(context).colorScheme.primary.withOpacity(0.2):Theme.of(context).colorScheme.background,
                      image:Appimages.groupCar,
                      carTape: 'Group (1-6)'),
                  CarSelectContainer(
                      ontap: (){
                        select=3;
                        setState(()=>());
                        Navigator.push(context, CupertinoPageRoute(builder: (context)=>SelectDestinationsView()));
                      },
                      borderColor: select==3?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.tertiary,
                      color: select==3?Theme.of(context).colorScheme.primary.withOpacity(0.2):Theme.of(context).colorScheme.background,
                      image:Appimages.partyCar,
                      carTape: 'Party (1-8)'),
              ],),
              //===================>> Text for Suggested Location
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: width*.01,vertical: height*.01),
                child: BoldText(text: 'Suggested Locations',fontSize: 16,color: Theme.of(context).colorScheme.secondary,),
              ),
              //===================>> Rows For Suggested Locations
              SuggestedLocation(
                 image: Appimages.location,
                 location: 'Islamabad Shopping Mall'
             ),
              SuggestedLocation(
                  image: Appimages.planeIcon,
                  location: 'Islamabad National Islamabad National Islamabad National  '
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
          ],),
        ),
      ),
    );
  }
}
