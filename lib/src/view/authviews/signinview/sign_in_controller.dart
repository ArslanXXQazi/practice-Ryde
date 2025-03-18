import 'package:flutter/cupertino.dart';

import '../../../controllers/constants/linker.dart';

class SignInController extends GetxController{

  TextEditingController passwordController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  var loading=false.obs;
  FirebaseAuth _auth=FirebaseAuth.instance;

void signIn(BuildContext context ) async
{
  loading.value=true;
  await _auth.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text).then((value){
    loading.value=false;
    Utils().toastMsg(
        "Login Successfully",
        context,
        Theme.of(context).colorScheme.background,
        ToastificationType.success);
          emailController.clear();
          passwordController.clear();
          Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=>NavBarView()));
  }).onError((e,handlee) {
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