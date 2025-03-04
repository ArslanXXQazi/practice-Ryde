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



