import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:practice_ryde/src/controllers/components/profile_container.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';

class ProfileNavView extends StatefulWidget {

  VoidCallback ontap;

  ProfileNavView({super.key,required this.ontap});

  @override
  State<ProfileNavView> createState() => _ProfileNavViewState();
}

class _ProfileNavViewState extends State<ProfileNavView> {
  @override

  final FirebaseAuth auth=FirebaseAuth.instance;

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
              child:ProfileContainer(image: Appimages.arslan),
            ),
            SizedBox(height: height*.01,),
            BoldText(text: 'John Doe',fontSize: 22,color: Theme.of(context).colorScheme.secondary,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.star,color: Appcolor.yellow,),
                BoldText(text: '4.9',fontSize: 16,color: Theme.of(context).colorScheme.secondary,),
              ],),
              ProfileIconRow(
                onTap: widget.ontap,
                 //  onTap: ()
                 //  {
                 // //   Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileView(image: Appimages.arslan,ontap: widget.ontap)));
                 //  },
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
                              BoldText(text: 'Are you sure you want to logout?',fontSize: 18,color: Theme.of(context).colorScheme.secondary,),
                              SizedBox(height: height*.01,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      onPressed: (){Navigator.pop(context);},
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context).colorScheme.background,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            side: BorderSide(color: Appcolor.grey),
                                          )
                                      ),
                                      child:CustomText(text: 'Go Back',color: Theme.of(context).colorScheme.secondary,)
                                  ),
                                  SizedBox(width: width*.03,),
                                  ElevatedButton(
                                      onPressed: () async{
                                        await auth.signOut().then((onValue){
                                          Navigator.push(context, CupertinoPageRoute(builder: (context)=>SignInView()));
                                        }).onError((error,handleError){

                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context).colorScheme.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          )
                                      ),
                                      child:CustomText(text: 'Log Out',color: Theme.of(context).colorScheme.secondary,)
                                  ),
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
}
