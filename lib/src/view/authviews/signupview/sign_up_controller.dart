
import 'package:flutter/cupertino.dart';

import '../../../controllers/constants/linker.dart';

// class SignUpController extends GetxController{
//
//   TextEditingController nameController=TextEditingController();
//   TextEditingController passwordController=TextEditingController();
//   TextEditingController emailController=TextEditingController();
//   var loading=false.obs;
//   FirebaseAuth _auth=FirebaseAuth.instance;
//
//   void signUp(BuildContext context) async
//   {
//     loading.value=true;
//   UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//       email: emailController.text.toString(),
//       password: passwordController.text.toString()).then((value){
//       loading.value=false;
//       value.user!.updateDisplayName(nameController.text.toString());
//       Utils().toastMsg(
//           "Sign Up Successfully",
//           context,
//           Theme.of(context).colorScheme.background,
//           ToastificationType.success
//       );
//       nameController.clear();
//       emailController.clear();
//       passwordController.clear();
//       Navigator.push(context,  CupertinoPageRoute(builder: (context)=>SignInView()));
//     }).onError((e,catcherror){
//       loading.value=false;
//       Utils().toastMsg(
//           e.toString(),
//           context,
//           Theme.of(context).colorScheme.background,
//           ToastificationType.error
//       );
//     });
//   }
//}


class SignUpController extends GetxController{
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var loading = false.obs;
  FirebaseAuth _auth = FirebaseAuth.instance;


  void signUp (BuildContext context) async{

    loading.value=true;
    try{
      UserCredential userCredential= await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.toString()
      );

      User? user=userCredential.user;

      if(user ! = null)
        {
          await user.updateDisplayName(nameController.text.toString());
          await user.sendEmailVerification();
          Utils().toastMsg(
          "Verification email sent. Please verify your email.",
          context,
          Theme.of(context).colorScheme.background,
          ToastificationType.success,
        );
        }



    }
    catch (e){

    }
  }

}


// import 'package:flutter/cupertino.dart';
// import '../../../controllers/constants/linker.dart';
//
// class SignUpController extends GetxController {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   var loading = false.obs;
//   FirebaseAuth _auth = FirebaseAuth.instance;
//
//   void signUp(BuildContext context) async {
//     loading.value = true;
//     try {
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );
//
//       User? user = userCredential.user;
//       if (user != null) {
//         await user.updateDisplayName(nameController.text.trim());
//         await user.sendEmailVerification(); // Send verification email
//
//         Utils().toastMsg(
//           "Verification email sent. Please verify your email.",
//           context,
//           Theme.of(context).colorScheme.background,
//           ToastificationType.success,
//         );
//
//         nameController.clear();
//         emailController.clear();
//         passwordController.clear();
//       }
//     } catch (e) {
//       Utils().toastMsg(
//         e.toString(),
//         context,
//         Theme.of(context).colorScheme.background,
//         ToastificationType.error,
//       );
//     } finally {
//       loading.value = false;
//     }
//   }
// }