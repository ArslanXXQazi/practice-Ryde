import 'package:path/path.dart' as path;
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/io_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../controllers/constants/linker.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  static EditProfileController get instance =>
      Get.find<EditProfileController>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxString networkImageUrl = RxString('');
  final RxBool isLoading = false.obs;
  final RxBool isUploadingImage = false.obs;
  final RxString userName = RxString('');
  final RxString userEmail = RxString('');

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  // Update profile information including image if selected
  void updateProfile(BuildContext context) async {
    isLoading.value = true;

    String userId = firebaseAuth.currentUser?.uid ?? "";
    if (userId.isEmpty) {
      Utils().toastMsg(
        "User not found",
        context,
        Theme.of(context).colorScheme.background,
        ToastificationType.error,);
      isLoading.value = false;
      return;
    }

    try {
      String imageUrl = networkImageUrl.value;

      // If user selected a new image, upload it
      if (selectedImage.value != null) {
        isUploadingImage.value = true;

        try {
          // Try direct upload with minimal processing
          String? uploadedImageUrl = await uploadImageSimple(
              selectedImage.value!);

          if (uploadedImageUrl != null && uploadedImageUrl.isNotEmpty) {
            imageUrl = uploadedImageUrl;
            print("Image uploaded successfully: $imageUrl");
          } else {
            print("Failed to upload image, keeping original URL");
          }
        } catch (e) {
          print("Error during image upload: $e");
        }
      }

      // Update user data in Firestore
      await FirebaseFirestore.instance.collection('userData')
          .doc(userId)
          .update({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'userPhone': phoneController.text.trim(),
        'userAddress': addressController.text.trim(),
        'photoUrl': imageUrl,
      });

      Utils().toastMsg(
        "Profile Update Successfully",
        context,
        Theme.of(context).colorScheme.background,
        ToastificationType.success,
      );

      // Refresh data after update
      fetchUserData();
    } catch (error) {
      Utils().toastMsg(
        "$error",
        context,
        Colors.white,
        ToastificationType.error,
      );
    } finally {
      isLoading.value = false;
      isUploadingImage.value = false;
    }
  }

  // Fetch user data from Firestore
  void fetchUserData() async {
    isLoading.value = true;

    String userId = firebaseAuth.currentUser?.uid ?? "";
    if (userId.isEmpty) return;

    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection(
          'userData').doc(userId).get();

      if (userDoc.exists) {
        var data = userDoc.data() as Map<String, dynamic>;

        nameController.text = data['name'] ?? '';
        userName.value = data['name'] ?? '';
        emailController.text = data['email'] ?? '';
        userEmail.value = data['email'] ?? '';
        phoneController.text = data['userPhone'] ?? '';
        addressController.text = data['userAddress'] ?? '';
        networkImageUrl.value = data['photoUrl'] ?? '';

        update();
      }
    } catch (error) {
      print("Error fetching user data: $error");
    } finally {
      isLoading.value = false;
    }
  }

  // Sign out function
  void signOut(BuildContext context) async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      Utils().toastMsg(
        "Error signing out",
        context,
        Theme.of(context).colorScheme.background,
        ToastificationType.error,);
    } finally {
      isLoading.value = false;
      Get.off(() => SignInView());
      Utils().toastMsg(
        "Logout Successfully",
        context,
        Theme.of(context).colorScheme.background,
        ToastificationType.success,);
    }
  }

  // Simplest possible image upload method
  Future<String?> uploadImageSimple(File imageFile) async {
    try {
      // Reduce image size before upload to prevent buffer issues
      File compressedImage = await _compressImageMinimal(imageFile);

      // Create an HttpClient that accepts self-signed certificates
      HttpClient httpClient = HttpClient()
        ..badCertificateCallback = (X509Certificate cert, String host,
            int port) => true;

      // Create an IOClient using our modified HttpClient
      var ioClient = IOClient(httpClient);

      // Create multipart request
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://api.codytech.solutions/api/RydeFileUpload/CustomerImage')
      );

      // Add file to request
      request.files.add(
          await http.MultipartFile.fromPath(
              'file',
              compressedImage.path
          )
      );


      // Use our IOClient that bypasses certificate verification
      var streamedResponse = await ioClient.send(request).timeout(
          Duration(seconds: 90));
      var response = await http.Response.fromStream(streamedResponse);


      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);


        if (jsonData != null && jsonData.containsKey('filePath')) {
          var filePath = jsonData['filePath'];
          return filePath;
        } else {
          print("Response doesn't contain filePath: $jsonData");
        }
      } else {
        print("Failed with status code: ${response.statusCode}");
      }

      return null;
    } catch (e) {
      print("Upload error: $e");
      return null;
    } finally {
      // Ensure we always set loading to false
      isUploadingImage.value = false;
    }
  }

  // Minimal image compression to avoid memory issues
  Future<File> _compressImageMinimal(File file) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final targetPath = path.join(tempDir.path, 'compressed_${DateTime
          .now()
          .millisecondsSinceEpoch}.jpg');

      // Wait briefly to let UI stabilize (helps with buffer issues)
      await Future.delayed(const Duration(milliseconds: 300));

      var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 40, // Lower quality
        minWidth: 400, // Smaller dimensions
        minHeight: 400,
        format: CompressFormat.jpeg,
      );

      if (result != null) {
        return File(result.path);
      }
      return file;
    } catch (e) {
      print("Compression error: $e");
      return file;
    }
  }

  // Pick image from gallery
  Future<void> pickImage() async {
    try {
      // Always dismiss keyboard and snackbars before image picking to free resources
      FocusManager.instance.primaryFocus?.unfocus();
      Get.closeAllSnackbars();

      // Add small delay to ensure UI is settled before picker opens
      await Future.delayed(const Duration(milliseconds: 300));

      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50, // Request lower quality from picker
        maxWidth: 500,
        maxHeight: 500,
      );

      if (pickedFile != null) {
        // Brief delay before updating UI with image
        await Future.delayed(const Duration(milliseconds: 300));
        selectedImage.value = File(pickedFile.path);
      }
    } catch (e) {
      print("Error picking image: $e");
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
