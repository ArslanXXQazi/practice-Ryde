
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';
import 'package:practice_ryde/src/utils/utils.dart';
import 'package:toastification/toastification.dart';

class SignUpController extends GetxController{

  TextEditingController nameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  bool loading=false;
  FirebaseAuth _auth=FirebaseAuth.instance;

  void signUp(BuildContext context) async
  {

    await _auth.createUserWithEmailAndPassword(email: emailController.text.toString(), password: passwordController.text.toString()).then((value){
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
      Utils().toastMsg(
          e.toString(),
          context,
          Theme.of(context).colorScheme.background,
          ToastificationType.error
      );
    });
  }




}