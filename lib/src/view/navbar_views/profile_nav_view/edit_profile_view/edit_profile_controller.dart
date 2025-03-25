
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../controllers/constants/linker.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart' as dio;  // ✅ Aliasing Dio package
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

class EditProfileController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> updateProfile() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      String userId = firebaseAuth.currentUser?.uid ?? "";
      if (userId.isEmpty) {
        throw 'User not found';
      }

      String? photoUrl = '';
      if (selectedImage.value != null) {
        String apiEndpoint = 'http://api.codytech.solutions/api/RydeFileUpload/CustomerImage';
        final uploadResult = await _uploadImage(selectedImage.value!, );

        if (uploadResult != null) {
          photoUrl = uploadResult;
          Get.snackbar('Success', 'Image uploaded successfully', snackPosition: SnackPosition.TOP);
        } else {
          throw 'Failed to upload image';
        }
      }

      await FirebaseFirestore.instance.collection('userData').doc(userId).update({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'userPhone': phoneController.text.trim(),
        'userAddress': addressController.text.trim(),
        'photoUrl': photoUrl,
      });

      Get.snackbar('Success', 'Profile updated successfully', snackPosition: SnackPosition.TOP);
      Get.back();
    } catch (e) {
      print("Error in updateProfile: $e");
      errorMessage.value = e.toString();
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }



  Future<String?> _uploadImage(File file) async {
    try {
      var uri = Uri.parse('http://api.codytech.solutions/api/RydeFileUpload/CustomerImage');

      var request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath('file', file.path));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return jsonResponse['filePath'];
      } else {
        return null;
      }
    } catch (e) {
      print('Upload error: $e');
      return null;
    }
  }
  Future<void> fetchUserData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      String userId = firebaseAuth.currentUser?.uid ?? "";
      if (userId.isEmpty) return;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('userData')
          .doc(userId)
          .get()
          .timeout(const Duration(seconds: 10));

      if (userDoc.exists) {
        var data = userDoc.data() as Map<String, dynamic>;
        nameController.text = data['name'] ?? '';
        emailController.text = data['email'] ?? '';
        phoneController.text = data['userPhone'] ?? '';
        addressController.text = data['userAddress'] ?? '';
      }
    } catch (e) {
      print("Error in fetchUserData: $e"); // ✅ Console log
      errorMessage.value = 'Failed to fetch user data: $e';
      Get.snackbar('Error', 'Failed to fetch user data', snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    try {
      isLoading.value = true;
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      }
    } catch (e) {
      print("Error in pickImage: $e"); // ✅ Console log
      errorMessage.value = 'Failed to pick image: $e';
      Get.snackbar('Error', 'Failed to pick image', snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }
}



// class EditProfileController extends GetxController{
//
//   TextEditingController nameController=TextEditingController();
//   TextEditingController emailController=TextEditingController();
//   TextEditingController phoneController=TextEditingController();
//   TextEditingController addressController=TextEditingController();
//   File? selectedImage;
//
//   FirebaseAuth firebaseAuth =FirebaseAuth.instance;
//
//   void updateProfile ( BuildContext context ) async
//   {
//
//     String userId=firebaseAuth.currentUser?.uid??"";
//     if(userId.isEmpty){
//       Utils().toastMsg("User not found", context, Colors.white, ToastificationType.error, //Colors.red
//       );
//       return;
//     }
//
//     try
//     {
//       await FirebaseFirestore.instance.collection('userData').doc(userId).update({
//         'name': nameController.text.trim(),
//         'email': emailController.text.trim(),
//         'userPhone': phoneController.text.trim(),
//         'userAddress': addressController.text.trim(),
//         'photoUrl':'',
//       });
//
//      //Navigator.pop(context);
//
//       Utils().toastMsg(
//           "Profile Update Successfully",
//           context,
//           Colors.white,
//           ToastificationType.success,
//         //  Colors.green
//       );
//
//
//     }
//     catch(error)
//     {
//
//       Utils().toastMsg(
//           "$error",
//           context,
//           Colors.white,
//           ToastificationType.error,
//       //    Colors.red
//       );
//
//     }
//   }
//
//
//   void fetchUserData() async
//   {
//     String userId = firebaseAuth.currentUser?.uid ?? "";
//     if (userId.isEmpty) return;
//
//     try {
//       DocumentSnapshot userDoc =
//       await FirebaseFirestore.instance.collection('userData').doc(userId).get();
//
//       if (userDoc.exists) {
//         var data = userDoc.data() as Map<String, dynamic>;
//
//         nameController.text = data['name'] ?? '';
//         emailController.text = data['email'] ?? '';
//         phoneController.text = data['userPhone'] ?? '';
//         addressController.text = data['userAddress'] ?? '';
//
//         update();
//
//       }
//     } catch (error) {
//       print("Error fetching user data: $error");
//     }
//   }
//
//
//   Future<void> pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       selectedImage = File(pickedFile.path);
//       update(); // UI update karne ke liye
//     }
//   }
//
// }
