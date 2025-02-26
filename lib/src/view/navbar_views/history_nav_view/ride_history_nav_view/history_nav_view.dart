

import 'package:practice_ryde/src/controllers/constants/linker.dart';


import '../../../../controllers/components/trips_container.dart';


class RideHistoryNavView extends StatefulWidget {
  VoidCallback ontap;
  RideHistoryNavView({super.key,
    required this.ontap
  });

  @override
  State<RideHistoryNavView> createState() => _RideHistoryNavViewState();
}

class _RideHistoryNavViewState extends State<RideHistoryNavView> {
 TextEditingController searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor:Theme.of(context).colorScheme.background,
      appBar: AppBar(
          automaticallyImplyLeading: false,
        backgroundColor:Theme.of(context).colorScheme.background,
        title: BoldText(
          text: 'Your Ride History',
          fontSize: 18,
          color: Theme.of(context).colorScheme.secondary,
        )
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width*.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            //============================>>>> TextFormField for search
            CustomTextFormField(
                hintText: 'Search trips',
                controller: searchController,
                suffixIcon: Icons.search,
            ),
              //============================>>>> Text For Trips
              SizedBox(height: height*.01,),
            CustomText(text: 'Your Trips',color: Theme.of(context).colorScheme.secondary,fontSize: 16,),
              TripsContainer(
                image: Appimages.soloCar,
                location: 'Islamabad Shopping Mall',
                carType: 'solo (1-4)',
                date: '12 Sep, 2023',
                price: '75',
                ontap: widget.ontap,
            ),
              TripsContainer(
                image: Appimages.groupCar,
                location: 'Islamabad Shopping Mall',
                carType: 'Group (1-6)',
                date: '12 Sep, 2023',
                price: '75',
                ontap: widget.ontap,
              ),
              TripsContainer(
                image: Appimages.partyCar,
                location: 'Islamabad Shopping Mall',
                carType: 'party (1-10)',
                date: '12 Sep, 2023',
                price: '75',
                ontap: widget.ontap,
              ),
              TripsContainer(
                image: Appimages.soloCar,
                location: 'Islamabad Shopping Mall',
                carType: 'solo (1-4)',
                date: '12 Sep, 2023',
                price: '75',
                ontap: widget.ontap,
              ),
              TripsContainer(
                image: Appimages.groupCar,
                location: 'Islamabad Shopping Mall',
                carType: 'Group (1-6)',
                date: '12 Sep, 2023',
                price: '75',
                ontap: widget.ontap,
              ),
              TripsContainer(
                image: Appimages.partyCar,
                location: 'Islamabad Shopping Mall',
                carType: 'party (1-10)',
                date: '12 Sep, 2023',
                price: '75',
                ontap: widget.ontap,
              ),
          ],),
        ),
      ),
    );
  }
}
