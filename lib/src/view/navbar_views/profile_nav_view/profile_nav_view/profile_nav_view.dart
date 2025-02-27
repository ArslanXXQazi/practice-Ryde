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
                  onTap: () async
                  {
                  await auth.signOut().then((onValue){
                      Navigator.push(context, CupertinoPageRoute(builder: (context)=>SignInView()));
                    }).onError((error,handleError){

                    });
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
