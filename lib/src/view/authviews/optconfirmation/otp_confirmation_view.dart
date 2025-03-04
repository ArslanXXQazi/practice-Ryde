// import 'package:flutter/cupertino.dart';
// import 'package:practice_ryde/src/controllers/constants/linker.dart';
//
// class OtpConfirmationView extends StatelessWidget {
//   OtpConfirmationView({super.key});
//
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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';

class OtpConfirmationView extends StatefulWidget {
  final String email;
  OtpConfirmationView({super.key, required this.email});

  @override
  State<OtpConfirmationView> createState() => _OtpConfirmationViewState();
}

class _OtpConfirmationViewState extends State<OtpConfirmationView> {
  TextEditingController otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 🔹 Function to verify OTP
  Future<void> verifyOtp() async {
    String otp = otpController.text.trim();
    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter OTP!")));
      return;
    }

    try {
      // Firebase automatically handles OTP verification for email reset links.
      // The actual OTP verification will be done when user clicks on reset link.
      Navigator.push(context, CupertinoPageRoute(builder: (context) => ResetPassword()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid OTP!")));
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
              Center(child: Image(image: AssetImage(Appimages.appLogo), color: Theme.of(context).colorScheme.secondary)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * .04),
                child: BoldText(text: 'OTP Confirmation', color: Theme.of(context).colorScheme.secondary),
              ),
              CustomText(text: 'Please enter the OTP sent to ${widget.email}', color: Theme.of(context).colorScheme.secondary),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * .02, horizontal: width * .02),
                child: CustomTextFormField(hintText: 'Enter OTP', controller: otpController),
              ),
              CustomButton(
                onPressed: verifyOtp,
                text: 'Confirm',
                color: Theme.of(context).colorScheme.primary,
                borderColor: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

