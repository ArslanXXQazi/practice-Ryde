
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:practice_ryde/src/controllers/components/profile_container.dart';
import 'package:practice_ryde/src/controllers/components/rich_text_form_field.dart';
import 'package:practice_ryde/src/view/navbar_views/profile_nav_view/edit_profile_view/edit_profile_controller.dart';

import '../../../../controllers/constants/linker.dart';



class EditProfileView extends StatefulWidget {
  String image;
  VoidCallback ontap;
  EditProfileView({super.key,required this.image,required this.ontap});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Allow self-signed certificates globally
    HttpOverrides.global = _MyHttpOverrides();

    controller.fetchUserData();
  }

  EditProfileController controller = Get.put(EditProfileController());

  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor:Theme.of(context).colorScheme.background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BoldText(text: 'Edit Profile',fontSize: 16,color: Theme.of(context).colorScheme.secondary,),
            Obx(() => controller.isLoading.value || controller.isUploadingImage.value
                ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2)
            )
                : TextButton(
              onPressed: (){
                controller.updateProfile(context);
              },
              child: BoldText(text: 'Save',fontSize: 18,color: Colors.blue),
            )
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: width*.03,vertical: height*.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    Obx(() {
                      if(controller.isUploadingImage.value) {
                        return Container(
                          width: width * 0.25,
                          height: width * 0.25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade300,
                          ),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      if(controller.selectedImage.value != null) {
                        return Container(
                          width: width * 0.25,
                          height: width * 0.25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: FileImage(controller.selectedImage.value!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }

                      if(controller.networkImageUrl.value.isNotEmpty) {
                        return ClipOval(
                          child: Container(
                            width: width * 0.25,
                            height: width * 0.25,
                            child: buildNetworkImage(controller.networkImageUrl.value, width),
                          ),
                        );
                      }

                      return ProfileContainer(image: widget.image);
                    }),
                    Padding(
                      padding: EdgeInsets.only(left: width * .18, top: height * .065),
                      child: GestureDetector(
                        onTap: () {
                          if(!controller.isUploadingImage.value) {
                            controller.pickImage();
                          }
                        },
                        child: CircleAvatar(
                          radius: width * .04,
                          backgroundColor: Appcolor.yellow,
                          child: Center(child: ImageIcon(AssetImage(Appimages.edit))),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              CustomText(text: 'Your Name',fontSize: 14,color: Theme.of(context).colorScheme.secondary,),
              CustomTextFormField(hintText: 'John Doe', controller: controller.nameController),
              CustomText(text: 'Email',fontSize: 14,color: Theme.of(context).colorScheme.secondary,),
              CustomTextFormField(hintText: 'johndoe@gmail.com', controller: controller.emailController),
              CustomText(text: 'Phone Number',fontSize: 14,color: Theme.of(context).colorScheme.secondary,),
              CustomTextFormField(hintText: '0348 3424529', controller: controller.phoneController),
              CustomText(text: 'Addess',fontSize: 14,color: Theme.of(context).colorScheme.secondary,),
              RichTextFormField(
                controller: controller.addressController,
                hintText: 'House no. 123, Street no. 456, Sector 7, Islamabad',
                maxLine: 2,
              ),
              SizedBox(height: 20),
            ],),
        ),
      ),
    );
  }

  // Function to build network image with fallbacks and error handling
  Widget buildNetworkImage(String url, double width) {
    print("Loading image from: $url");

    // Try to display the image with error handling
    return Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
                : null,
            strokeWidth: 2,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        print("Error loading image: $error");
        // Fallback to default profile
        return Image.asset(
          widget.image,
          fit: BoxFit.cover,
        );
      },
    );
  }
}

// Custom HTTP overrides to accept self-signed certificates
class _MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}





// class EditProfileView extends StatefulWidget {
//   String image;
//   VoidCallback ontap;
//    EditProfileView({super.key,required this.image,required this.ontap});
//
//   @override
//   State<EditProfileView> createState() => _EditProfileViewState();
// }
// class _EditProfileViewState extends State<EditProfileView> {
//   // Add these new variables
//   File? _selectedImage; // To store the picked image
//   final ImagePicker _picker = ImagePicker(); // Image picker instance
//
//   @override
//   void initState() {
//     super.initState();
//     controller.fetchUserData();
//   }
//
//   EditProfileController controller = Get.put(EditProfileController());
//
//   // Add this method to pick image from gallery
//   Future<void> _pickImage() async {
//     try {
//       final XFile? pickedFile = await _picker.pickImage(
//         source: ImageSource.gallery,
//       //  maxWidth: 800, // Optional: to limit image size
//         //maxHeight: 800,
//       );
//
//       if (pickedFile != null) {
//         setState(() {
//           _selectedImage = File(pickedFile.path);
//         });
//       }
//     } catch (e) {
//       print('Error picking image: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.sizeOf(context).width;
//     final height = MediaQuery.sizeOf(context).height;
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Theme.of(context).colorScheme.background,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             BoldText(
//               text: 'Edit Profile',
//               fontSize: 16,
//               color: Theme.of(context).colorScheme.secondary,
//             ),
//             TextButton(
//               onPressed: () {
//                 controller.updateProfile(context);
//               },
//               child: BoldText(text: 'Save', fontSize: 18, color: Colors.blue),
//             )
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: width * .03, vertical: height * .02),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Stack(
//                   children: [
//                     // Modify ProfileContainer to show selected image if available
//                     _selectedImage != null
//                         ? Container(
//                       width: width * 0.25, // Adjust size as needed
//                       height: width * 0.25,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         image: DecorationImage(
//                           image: FileImage(_selectedImage!),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     )
//                         : ProfileContainer(image: widget.image),
//                     Padding(
//                       padding: EdgeInsets.only(left: width * .18, top: height * .065),
//                       child: GestureDetector(
//                         onTap: _pickImage, // Call pick image method on tap
//                         child: CircleAvatar(
//                           radius: width * .04,
//                           backgroundColor: Appcolor.yellow,
//                           child: Center(child: ImageIcon(AssetImage(Appimages.edit))),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               CustomText(
//                 text: 'Your Name',
//                 fontSize: 14,
//                 color: Theme.of(context).colorScheme.secondary,
//               ),
//               CustomTextFormField(hintText: 'John Doe', controller: controller.nameController),
//               CustomText(
//                 text: 'Email',
//                 fontSize: 14,
//                 color: Theme.of(context).colorScheme.secondary,
//               ),
//               CustomTextFormField(hintText: 'johndoe@gmail.com', controller: controller.emailController),
//               CustomText(
//                 text: 'Phone Number',
//                 fontSize: 14,
//                 color: Theme.of(context).colorScheme.secondary,
//               ),
//               CustomTextFormField(hintText: '0348 3424529', controller: controller.phoneController),
//               CustomText(
//                 text: 'Addess',
//                 fontSize: 14,
//                 color: Theme.of(context).colorScheme.secondary,
//               ),
//               RichTextFormField(
//                 controller: controller.addressController,
//                 hintText: 'House no. 123, Street no. 456, Sector 7, Islamabad',
//                 maxLine: 2,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




// class _EditProfileViewState extends State<EditProfileView> {
//   @override
// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     controller.fetchUserData();
//   }
//   EditProfileController controller = Get.put(EditProfileController());
//
//   Widget build(BuildContext context) {
//     final width=MediaQuery.sizeOf(context).width;
//     final height=MediaQuery.sizeOf(context).height;
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor:Theme.of(context).colorScheme.background,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             BoldText(text: 'Edit Profile',fontSize: 16,color: Theme.of(context).colorScheme.secondary,),
//             TextButton(
//               onPressed: (){
//                 controller.updateProfile(context);
//               },
//               child:  BoldText(text: 'Save',fontSize: 18,color: Colors.blue),
//             )
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding:  EdgeInsets.symmetric(horizontal: width*.03,vertical: height*.02),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//             Center(
//                 child:Stack(
//                   children: [
//                     ProfileContainer(image: widget.image),
//                     Padding(
//                       padding:  EdgeInsets.only(left: width*.18,top: height*.065),
//                       child: GestureDetector(
//                         onTap: (){},
//                         child: CircleAvatar(
//                           radius: width*.04,
//                           backgroundColor: Appcolor.yellow,
//                           child: Center(child: ImageIcon(AssetImage(Appimages.edit))),
//                         ),
//                       ),
//                     )
//                   ],
//                 )
//             ),
//             CustomText(text: 'Your Name',fontSize: 14,color: Theme.of(context).colorScheme.secondary,),
//             CustomTextFormField(hintText: 'John Doe', controller: controller.nameController),
//             CustomText(text: 'Email',fontSize: 14,color: Theme.of(context).colorScheme.secondary,),
//             CustomTextFormField(hintText: 'johndoe@gmail.com', controller: controller.emailController),
//             CustomText(text: 'Phone Number',fontSize: 14,color: Theme.of(context).colorScheme.secondary,),
//             CustomTextFormField(hintText: '0348 3424529', controller: controller.phoneController),
//             CustomText(text: 'Addess',fontSize: 14,color: Theme.of(context).colorScheme.secondary,),
//             RichTextFormField(
//                 controller: controller.addressController,
//                 hintText: 'House no. 123, Street no. 456, Sector 7, Islamabad',
//                 maxLine: 2,
//             )
//           ],),
//         ),
//       ),
//     );
//   }
// }



