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
  final String otp;
  OtpConfirmationView({super.key, required this.otp});

  final TextEditingController firstController = TextEditingController();
  final TextEditingController secondController = TextEditingController();
  final TextEditingController thirdController = TextEditingController();
  final TextEditingController fourthController = TextEditingController();
  final TextEditingController fifthController = TextEditingController();

  void verifyOTP(BuildContext context) {
    String enteredOTP = "${firstController.text}${secondController.text}${thirdController.text}${fourthController.text}${fifthController.text}";
    if (enteredOTP == otp) {
      print("✅ OTP Verified!");
      toastification.show(
        context: context,
        title: Text("OTP Verified Successfully!"),
        autoCloseDuration: Duration(seconds: 3),
      );
      // Yahaan next screen ka navigation ya success message dikhana hai
    } else {
      print("❌ Invalid OTP");
      toastification.show(
        context: context,
        title: Text("Invalid OTP!"),
        autoCloseDuration: Duration(seconds: 3),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Icon(Icons.security, size: 100, color: Colors.blue)),
            SizedBox(height: 20),
            Text("Enter OTP", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Enter the 5-digit code sent to your email"),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OtpTextformfield(controller: firstController),
                OtpTextformfield(controller: secondController),
                OtpTextformfield(controller: thirdController),
                OtpTextformfield(controller: fourthController),
                OtpTextformfield(controller: fifthController),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => verifyOTP(context),
              child: Text("Verify OTP"),
            ),
          ],
        ),
      ),
    );
  }
}

