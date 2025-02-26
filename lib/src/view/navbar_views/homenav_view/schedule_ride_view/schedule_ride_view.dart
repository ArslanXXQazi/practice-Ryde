import 'package:flutter/cupertino.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';

class ScheduleRideView extends StatefulWidget {
 const  ScheduleRideView({super.key});

  @override
  State<ScheduleRideView> createState() => _ScheduleRideViewState();
}

class _ScheduleRideViewState extends State<ScheduleRideView> {

TextEditingController dateController=TextEditingController();
TextEditingController timeController=TextEditingController();
// Date Picker Function
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        dateController.text =
        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }
  // Time Picker Function
  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        timeController.text = pickedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back,color: Theme.of(context).colorScheme.secondary,)),
        title:BoldText(text: 'Schedule a Ride',fontSize: 18,color:Theme.of(context).colorScheme.secondary,),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical:height*.02,horizontal: width*.03),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: 'Enter Date',color: Theme.of(context).colorScheme.secondary,),
              TextFormFieldIconButton(
                onTap: (){
                  _selectDate(context);
                },
                hintText: 'Select Date',
                controller: dateController,
                iconData: Icons.date_range_outlined,
              ),
              CustomText(text: 'Enter Time',color: Theme.of(context).colorScheme.secondary,),
              TextFormFieldIconButton(
                onTap: (){
                  _selectTime(context);
                },
                hintText: 'Select Time',
                controller: timeController,
                iconData: Icons.timer,
              ),
              Column(children: [
                CustomText(text: 'After you submitted your request for a',fontSize: 16,color: Theme.of(context).colorScheme.secondary,),
                CustomText(text: 'scheduled ride, a driver will be assigned to you.',fontSize: 16,color: Theme.of(context).colorScheme.secondary,),
                CustomText(text: 'Driver details will be viewable 20 minutes before',fontSize: 16,color: Theme.of(context).colorScheme.secondary,),
                CustomText(text: 'the booking.',fontSize: 16,color: Theme.of(context).colorScheme.secondary,),
              ],),
              Padding(
                padding:  EdgeInsets.only(top: height*.4),
                child: CustomButton(
                  onPressed: ()
                  {
                   if(timeController.text.isNotEmpty&&dateController.text.isNotEmpty)
                     {
                       showDialog(
                         context: context,
                         builder: (BuildContext context){
                           return AlertDialog(
                             backgroundColor: Theme.of(context).colorScheme.background,
                             title:Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 BoldText(text: 'Confirm Ride Details',fontSize: 18,color: Theme.of(context).colorScheme.secondary,),
                                 SizedBox(height: height*.02,),
                                 BoldText(text: 'From',fontSize: 18,color: Theme.of(context).colorScheme.secondary),
                                 CustomText(text: 'Street 123, Sector 4',color: Theme.of(context).colorScheme.secondary),
                                 SizedBox(height: height*.01,),
                                 BoldText(text: 'To',fontSize: 18,color: Theme.of(context).colorScheme.secondary),
                                 CustomText(text: 'Islamabad Shopping Mall',color: Theme.of(context).colorScheme.secondary),
                                 SizedBox(height: height*.01,),
                                 BoldText(text: 'Taxi Type',fontSize: 18,color: Theme.of(context).colorScheme.secondary),
                                 CustomText(text: 'Solo (1-4)',color: Theme.of(context).colorScheme.secondary),
                                 SizedBox(height: height*.01,),
                                 BoldText(text: 'Time and Date',fontSize: 18,color: Theme.of(context).colorScheme.secondary),
                                 CustomText(text: '2:35 pm - 12th May, 2023',color: Theme.of(context).colorScheme.secondary),
                                 SizedBox(height: height*.01,),
                                 BoldText(text: 'Fare',fontSize: 18,color: Theme.of(context).colorScheme.secondary),
                                 CustomText(text: '\$76',color: Theme.of(context).colorScheme.secondary),
                                 SizedBox(height: height*.01,),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     ElevatedButton(
                                         onPressed: (){Navigator.pop(context);},
                                         style: ElevatedButton.styleFrom(
                                             backgroundColor: Theme.of(context).colorScheme.background,
                                             shape: RoundedRectangleBorder(
                                               borderRadius: BorderRadius.circular(10),
                                               side: BorderSide(color: Appcolor.grey),
                                             )
                                         ),
                                         child:CustomText(text: 'Go Back',color: Theme.of(context).colorScheme.secondary,)
                                     ),
                                     SizedBox(width: width*.03,),
                                     ElevatedButton(
                                         onPressed: (){
                                           Navigator.push(context, CupertinoPageRoute(builder: (context)=>FindingDriverView()));
                                         },
                                         style: ElevatedButton.styleFrom(
                                             backgroundColor: Theme.of(context).colorScheme.primary,
                                             shape: RoundedRectangleBorder(
                                               borderRadius: BorderRadius.circular(10),
                                             )
                                         ),
                                         child:CustomText(text: 'Confirm',color: Theme.of(context).colorScheme.secondary,)
                                     ),
                                   ],)
                               ],
                             ),
                           );
                         },
                       );
                     }
                   else
                     {
                       final snackBar= SnackBar(
                         content: CustomText(text: 'Please Select Date and Time',fontSize: 16,color: Colors.red),
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
                     text:'Submit Request',
                  color: Theme.of(context).colorScheme.primary,
                  borderColor: Theme.of(context).colorScheme.primary,
                ),
              ),
          ],),
        ),
      ),
    );
  }
}
