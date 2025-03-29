import 'package:flutter/cupertino.dart';


import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:practice_ryde/src/controllers/components/profile_container.dart';
import 'package:practice_ryde/src/controllers/components/rich_text_form_field.dart';
import 'package:practice_ryde/src/view/navbar_views/profile_nav_view/edit_profile_view/edit_profile_controller.dart';
import '../../../../controllers/constants/linker.dart';


class ProfileNavView extends StatefulWidget {

  VoidCallback ontap;

  ProfileNavView({super.key,required this.ontap});

  @override
  State<ProfileNavView> createState() => _ProfileNavViewState();
}

class _ProfileNavViewState extends State<ProfileNavView> {

  EditProfileController profileController = Get.find<EditProfileController>();

  @override
  void initState() {
    super.initState();
    // Allow self-signed certificates globally for network image loading
    HttpOverrides.global = _MyHttpOverrides();
  }

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor:Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor:Theme.of(context).colorScheme.background,
        automaticallyImplyLeading: false,
        title: BoldText(text: 'Your Profile',fontSize: 16,color: Theme.of(context).colorScheme.secondary,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: width*.04,vertical: height*.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Obx(() {
                  if (profileController.isLoading.value) {
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

                  if (profileController.networkImageUrl.value.isNotEmpty) {
                    return ClipOval(
                      child: Container(
                        width: width * 0.25,
                        height: width * 0.25,
                        child: buildNetworkImage(profileController.networkImageUrl.value),
                      ),
                    );
                  }

                  return ProfileContainer(image: Appimages.arslan);
                }),
              ),
              SizedBox(height: height*.01,),
              Obx(() => BoldText(
                text: profileController.userName.value.isEmpty ? 'John Doe' : profileController.userName.value,
                fontSize: 22,
                color: Theme.of(context).colorScheme.secondary,
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star,color: Appcolor.yellow,),
                  BoldText(text: '4.9',fontSize: 16,color: Theme.of(context).colorScheme.secondary,),
                ],),
              ProfileIconRow(
                  onTap: widget.ontap,
                  image: Appimages.editProfile,
                  text: 'Edit Profile'
              ),
              LineContainer(),
              ProfileIconRow(
                  onTap: (){},
                  image: Appimages.help,
                  text: 'Help & Support'
              ),
              LineContainer(),
              ProfileIconRow(
                  onTap: (){},
                  image: Appimages.settings,
                  text: 'Settings'
              ),
              LineContainer(),
              ProfileIconRow(
                onTap: ()
                {
                  showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        backgroundColor: Theme.of(context).colorScheme.background,
                        title:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BoldText(text: 'Are you sure you want to log out?',fontSize: 16,color: Theme.of(context).colorScheme.secondary,),
                            // Image(image: AssetImage('assets/alert.png')).animate().rotate(duration: Duration(seconds: 2)),
                            SizedBox(height: height*.02,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(child:CustomButton(
                                  onPressed: (){Navigator.pop(context);},
                                  text: 'Go Back',
                                  borderColor:Theme.of(context).colorScheme.secondary,
                                  color:Theme.of(context).colorScheme.background,
                                  fontColor:Theme.of(context).colorScheme.secondary,
                                ),
                                ),
                                SizedBox(width: width*.06,),
                                Expanded(child: CustomButton(
                                  onPressed: () {
                                    profileController.signOut(context);
                                  },
                                  text: "Log Out",
                                  borderColor:Theme.of(context).colorScheme.primary,
                                  color:Theme.of(context).colorScheme.primary,
                                  fontColor:Theme.of(context).colorScheme.secondary,
                                ))

                              ],)
                          ],
                        ),
                      );
                    },
                  );
                },
                image: Appimages.logout,
                text: 'Log Out',
              ),
            ],),
        ),
      ),
    );
  }

  // Function to build network image with error handling
  Widget buildNetworkImage(String url) {
    print("Loading profile image from: $url");

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
        print("Error loading profile image: $error");
        return Image.asset(
          Appimages.arslan,
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

// class ProfileNavView extends StatefulWidget {
//
//   VoidCallback ontap;
//
//   ProfileNavView({super.key,required this.ontap});
//
//   @override
//   State<ProfileNavView> createState() => _ProfileNavViewState();
// }
// class _ProfileNavViewState extends State<ProfileNavView> {
//
//   ProfileNAvController profileNAvController=Get.put(ProfileNAvController());
//
//   @override
//   Widget build(BuildContext context) {
//     final width=MediaQuery.sizeOf(context).width;
//     final height=MediaQuery.sizeOf(context).height;
//     return Scaffold(
//       backgroundColor:Theme.of(context).colorScheme.background,
//       appBar: AppBar(
//         backgroundColor:Theme.of(context).colorScheme.background,
//         automaticallyImplyLeading: false,
//         title: BoldText(text: 'Your Profile',fontSize: 16,color: Theme.of(context).colorScheme.secondary,),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding:  EdgeInsets.symmetric(horizontal: width*.04,vertical: height*.02),
//           child: Column(
//            crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//             Center(
//               child:ProfileContainer(image: Appimages.arslan),
//             ),
//             SizedBox(height: height*.01,),
//             BoldText(text: 'John Doe',fontSize: 22,color: Theme.of(context).colorScheme.secondary,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                 Icon(Icons.star,color: Appcolor.yellow,),
//                 BoldText(text: '4.9',fontSize: 16,color: Theme.of(context).colorScheme.secondary,),
//               ],),
//               ProfileIconRow(
//                 onTap: widget.ontap,
//                  //  onTap: ()
//                  //  {
//                  // //   Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileView(image: Appimages.arslan,ontap: widget.ontap)));
//                  //  },
//                   image: Appimages.editProfile,
//                   text: 'Edit Profile'
//               ),
//               LineContainer(),
//               ProfileIconRow(
//                   onTap: (){},
//                   image: Appimages.help,
//                   text: 'Help & Support'
//               ),
//               LineContainer(),
//               ProfileIconRow(
//                   onTap: (){},
//                   image: Appimages.settings,
//                   text: 'Settings'
//               ),
//               LineContainer(),
//               ProfileIconRow(
//                   onTap: ()
//                   {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context){
//                         return AlertDialog(
//                           backgroundColor: Theme.of(context).colorScheme.background,
//                           title:Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               BoldText(text: 'Are you sure you want to log out?',fontSize: 16,color: Theme.of(context).colorScheme.secondary,),
//                               // Image(image: AssetImage('assets/alert.png')).animate().rotate(duration: Duration(seconds: 2)),
//                               SizedBox(height: height*.02,),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Expanded(child:CustomButton(
//                                     onPressed: (){Navigator.pop(context);},
//                                       text: 'Go Back',
//                                     borderColor:Theme.of(context).colorScheme.secondary,
//                                     color:Theme.of(context).colorScheme.background,
//                                     fontColor:Theme.of(context).colorScheme.secondary,
//                                       ),
//                                   ),
//                                   SizedBox(width: width*.06,),
//                                   Expanded(child: CustomButton(
//                                     onPressed: () {
//                                       profileNAvController.signOut(context);
//                                     },
//                                     text: "Log Out",
//                                     borderColor:Theme.of(context).colorScheme.primary,
//                                     color:Theme.of(context).colorScheme.primary,
//                                     fontColor:Theme.of(context).colorScheme.secondary,
//                                   ))
//
//                                 ],)
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   },
//                   image: Appimages.logout,
//                   text: 'Log Out',
//               ),
//           ],),
//         ),
//       ),
//     );
//   }
// }
