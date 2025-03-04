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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';

class OtpConfirmationView extends StatelessWidget {
  OtpConfirmationView({super.key, required this.email}); // Email ko pass karna zaroori hai

  final String email; // User ka email store karne ke liye
  final TextEditingController firstController = TextEditingController();
  final TextEditingController secondController = TextEditingController();
  final TextEditingController thirdController = TextEditingController();
  final TextEditingController fourthController = TextEditingController();
  final TextEditingController fifthController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore instance

  void verifyOTP(BuildContext context) async {
    String enteredOTP =
        firstController.text + secondController.text + thirdController.text + fourthController.text + fifthController.text;

    // Firestore se OTP fetch karna
    DocumentSnapshot snapshot =
    await _firestore.collection("otp_verification").doc(email).get();

    if (snapshot.exists) {
      String storedOTP = snapshot["otp"];
      if (enteredOTP == storedOTP) {
        // OTP Match ho gaya, next screen pe jao
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => ResetPassword()),
        );
      } else {
        // Agar OTP match nahi karta
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid OTP! Try again.")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP not found!")),
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
                child: Image(
                  image: AssetImage(Appimages.appLogo),
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * .04),
                child: BoldText(
                  text: 'OTP Confirmation',
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              CustomText(
                text: 'Please enter the 5-digit code sent to your email for confirmation',
                color: Theme.of(context).colorScheme.secondary,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * .02, horizontal: width * .02),
                child: Row(
                  children: [
                    Expanded(child: OtpTextformfield(controller: firstController)),
                    SizedBox(width: width * .04),
                    Expanded(child: OtpTextformfield(controller: secondController)),
                    SizedBox(width: width * .04),
                    Expanded(child: OtpTextformfield(controller: thirdController)),
                    SizedBox(width: width * .04),
                    Expanded(child: OtpTextformfield(controller: fourthController)),
                    SizedBox(width: width * .04),
                    Expanded(child: OtpTextformfield(controller: fifthController)),
                  ],
                ),
              ),
              CustomButton(
                onPressed: () => verifyOTP(context),
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

