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


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';

class ForgotPasswordView extends StatefulWidget {
  ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 🔹 Function to send OTP email
  Future<void> sendOtp() async {
    String email = emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter email!")));
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("OTP sent to your email!")));
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (context) => OtpConfirmationView(email: email)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: height * .07, horizontal: width * .04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image(image: AssetImage(Appimages.appLogo), color: Theme.of(context).colorScheme.secondary)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * .04),
                child: BoldText(text: 'Forgot Password?', color: Theme.of(context).colorScheme.secondary),
              ),
              CustomText(text: 'Enter your email address and we’ll send you a link to reset your password', color: Theme.of(context).colorScheme.secondary),
              CustomTextFormField(hintText: 'Enter your email', controller: emailController),
              CustomButton(
                onPressed: sendOtp,
                text: 'Send Link',
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

