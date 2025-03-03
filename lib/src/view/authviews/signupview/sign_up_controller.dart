
import 'package:flutter/cupertino.dart';

import '../../../controllers/constants/linker.dart';

class SignUpController extends GetxController{

  TextEditingController nameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  var loading=false.obs;
  FirebaseAuth _auth=FirebaseAuth.instance;

  void signUp(BuildContext context) async
  {
    loading.value=true;
    await _auth.createUserWithEmailAndPassword(email: emailController.text.toString(), password: passwordController.text.toString()).then((value){
      loading.value=false;
      value.user!.updateDisplayName(nameController.text.toString());
      Utils().toastMsg(
          "Sign Up Successfully",
          context,
          Theme.of(context).colorScheme.background,
          ToastificationType.success
      );
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      Navigator.push(context,  CupertinoPageRoute(builder: (context)=>SignInView()));
    }).onError((e,catcherror){
      loading.value=false;
      Utils().toastMsg(
          e.toString(),
          context,
          Theme.of(context).colorScheme.background,
          ToastificationType.error
      );
    });
  }




}