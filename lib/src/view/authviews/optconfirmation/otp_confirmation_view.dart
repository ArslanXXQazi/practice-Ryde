// import 'package:flutter/cupertino.dart';
// import 'package:practice_ryde/src/controllers/constants/linker.dart';
//
// class OtpConfirmationView extends StatelessWidget {
//   OtpConfirmationView({super.key});
// TextEditingController firstController =TextEditingController();
// TextEditingController secondController =TextEditingController();
// TextEditingController thirdController =TextEditingController();
// TextEditingController fourthController =TextEditingController();
// TextEditingController fifthController =TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     final width=MediaQuery.sizeOf(context).width;
//     final height=MediaQuery.sizeOf(context).height;
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       body: Padding(
//         padding:  EdgeInsets.symmetric(horizontal: width*.04,vertical: height*.07),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(child: Image(image: AssetImage(Appimages.appLogo),color: Theme.of(context).colorScheme.secondary,)),
//             Padding(
//               padding:  EdgeInsets.symmetric(vertical:height*.04),
//               child: BoldText(text: 'OTP Confirmation',color: Theme.of(context).colorScheme.secondary,),
//             ),
//             CustomText(text: 'Please enter the 5-digit code sent to your email for confirmation',color: Theme.of(context).colorScheme.secondary,),
//               Padding(
//                 padding:  EdgeInsets.symmetric(vertical: height*.02,horizontal: width*.02),
//                 child: Row(children: [
//                   Expanded(child: OtpTextformfield(controller: firstController)),
//                   SizedBox(width: width*.04,),
//                   Expanded(child: OtpTextformfield(controller: secondController)),
//                   SizedBox(width: width*.04,),
//                   Expanded(child: OtpTextformfield(controller: thirdController)),
//                   SizedBox(width: width*.04,),
//                   Expanded(child: OtpTextformfield(controller: fourthController)),
//                   SizedBox(width: width*.04,),
//                   Expanded(child: OtpTextformfield(controller: fifthController)),
//                 ],),
//               ),
//               CustomButton(
//                   onPressed: (){
//                     Navigator.push(context, CupertinoPageRoute(builder: (context)=>ResetPassword()));
//                   },
//                 text: 'Confirm',
//                 color: Theme.of(context).colorScheme.primary,
//                 borderColor: Theme.of(context).colorScheme.primary,
//               ),
//           ],),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';
import 'package:toastification/toastification.dart';

//import 'reset_password.dart';  // Reset password screen ka import

class OtpConfirmationView extends StatelessWidget {
  final String generatedOtp;
  OtpConfirmationView({super.key, required this.generatedOtp});

  final List<TextEditingController> controllers = List.generate(5, (index) => TextEditingController());

  void verifyOTP(BuildContext context) {
    String enteredOTP = controllers.map((c) => c.text).join();
    if (enteredOTP == generatedOtp) {
      toastification.show(
        context: context,
        title: Text("OTP Verified!"),
        autoCloseDuration: Duration(seconds: 3),
      );
    } else {
      toastification.show(
        context: context,
        title: Text("Invalid OTP"),
        autoCloseDuration: Duration(seconds: 3),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .04, vertical: height * .07),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(Icons.verified, size: 100, color: Colors.green),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * .04),
                child: Text('OTP Confirmation',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              Text('Please enter the 5-digit code sent to your email for confirmation'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * .02, horizontal: width * .02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * .02),
                      child: SizedBox(
                        width: 50,
                        child: TextField(
                          controller: controllers[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: "",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => verifyOTP(context),
                child: Text("Confirm OTP"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
