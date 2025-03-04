
import 'package:flutter/cupertino.dart';

import '../../../controllers/constants/linker.dart';
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

      if(user!=null)
        {
          await user.updateDisplayName(nameController.text.toString());
          await user.sendEmailVerification();
          Utils().toastMsg(
          "Verification email sent. Please verify your email.",
          context,
          Theme.of(context).colorScheme.background,
          ToastificationType.success,
        );

          nameController.clear();
          emailController.clear();
          passwordController.clear();

        }
    }
    catch (e){
      Utils().toastMsg(
        e.toString(),
        context,
        Theme.of(context).colorScheme.background,
        ToastificationType.error,
      );
    }
    finally{
      loading.value=false;
    }
  }

}


