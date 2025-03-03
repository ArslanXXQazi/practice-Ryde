// import 'package:flutter/cupertino.dart';
// import 'package:practice_ryde/src/controllers/constants/linker.dart';
//
// class ForgotPasswordView extends StatelessWidget {
//   ForgotPasswordView({super.key});
// TextEditingController emailController=TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     final width=MediaQuery.sizeOf(context).width;
//     final height=MediaQuery.sizeOf(context).height;
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       body: Padding(
//         padding:  EdgeInsets.symmetric(vertical: height*.07,horizontal: width*.04),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(child: Image(image: AssetImage(Appimages.appLogo),color: Theme.of(context).colorScheme.secondary,)),
//               Padding(
//                 padding:  EdgeInsets.symmetric(vertical:height*.04),
//                 child: BoldText(text: 'Forgot Password?',color: Theme.of(context).colorScheme.secondary,),
//               ),
//               CustomText(text: 'Enter your email address and we’ll send you a link to reset your password',color: Theme.of(context).colorScheme.secondary,),
//               CustomTextFormField(hintText: 'Enter your email', controller: emailController),
//               CustomButton(
//                 onPressed: (){
//                   Navigator.push(context, CupertinoPageRoute(builder: (context)=>OtpConfirmationView()));
//                 },
//                 text: 'Send Link',
//                 color: Theme.of(context).colorScheme.primary,
//                 borderColor: Theme.of(context).colorScheme.primary,
//               ),
//           ],),
//         ),
//       ),
//     );
//   }
// }


import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:toastification/toastification.dart';
import 'package:mailer/mailer.dart' as mailer;

import '../../../controllers/constants/linker.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  final TextEditingController emailController = TextEditingController();
  String generatedOtp = '';

  void sendOtp(BuildContext context) async {
    String email = emailController.text.trim();
    if (email.isEmpty) {
      toastification.show(
        context: context,
        title: Text("Please enter an email"),
        autoCloseDuration: Duration(seconds: 3),
      );
      return;
    }

    generatedOtp = (10000 + Random().nextInt(90000)).toString(); // 5-digit OTP generate
    print("Generated OTP: $generatedOtp"); // Debugging

    final smtpServer = gmail('your-email@gmail.com', 'your-app-password');
    final message = Message()
      ..from = Address('your-email@gmail.com', 'Your App Name')
      ..recipients.add(email)
      ..subject = 'Your OTP Code'
      ..text = 'Your OTP code is: $generatedOtp';

    try {
      final sendReport = await send(message, smtpServer);
      print('OTP Sent: ${sendReport.toString()}');

      toastification.show(
        context: context,
        title: Text("OTP sent to $email"),
        autoCloseDuration: Duration(seconds: 3),
      );

      Get.to(() => OtpConfirmationView(otp: generatedOtp));
    } catch (e) {
      print('Error: $e');
      toastification.show(
        context: context,
        title: Text("Error sending OTP"),
        autoCloseDuration: Duration(seconds: 3),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Icon(Icons.lock_reset, size: 100, color: Colors.blue)),
            SizedBox(height: 20),
            Text("Forgot Password?", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Enter your email to receive a 5-digit OTP"),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Enter your email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => sendOtp(context),
              child: Text("Send OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
