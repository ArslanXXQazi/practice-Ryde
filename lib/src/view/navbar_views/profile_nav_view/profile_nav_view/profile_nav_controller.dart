


import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:practice_ryde/src/controllers/components/profile_container.dart';
import 'package:practice_ryde/src/controllers/components/rich_text_form_field.dart';
import 'package:practice_ryde/src/view/navbar_views/profile_nav_view/edit_profile_view/edit_profile_controller.dart';

import '../../../../controllers/constants/linker.dart';


class ProfileNAvController extends GetxController{


  FirebaseAuth auth =FirebaseAuth.instance;

  void signOut (BuildContext context) async
  {
    await auth.signOut().then((onValue){
     Get.offAll(SignInView());
     Utils().toastMsg(
         "Log Out Successfully",
         context,
         Colors.white,
         ToastificationType.success,
        // Colors.green
     );
    }).onError((error,handleError){
      Utils().toastMsg(
          "$error",
          context,
          Colors.white,
          ToastificationType.error,
          //Colors.red
      );
    });
  }

}