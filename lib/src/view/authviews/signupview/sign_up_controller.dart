
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
          String userId=user.uid;
          await FirebaseFirestore.instance.collection('userData').doc(userId).set({
            'userId':userId,
            'email': emailController.text.trim(),
            'name' : nameController.text,
          });
          Navigator.push(context, CupertinoPageRoute(builder: (context)=>SignInView()));
          Utils().toastMsg(
          "Account Create Successfully",
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


