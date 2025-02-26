import 'package:flutter/cupertino.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';

class ResetPassword extends StatelessWidget {
   ResetPassword({super.key});
TextEditingController passwordController=TextEditingController();
TextEditingController confirmPasswordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: height*.07,horizontal: width*.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Center(child: Image(image: AssetImage(Appimages.appLogo),color: Theme.of(context).colorScheme.secondary,)),
            Padding(
              padding:  EdgeInsets.symmetric(vertical:height*.03),
              child: BoldText(text: 'Reset Password',color: Theme.of(context).colorScheme.secondary,),

            ),
              CustomText(text: 'New Password',color: Theme.of(context).colorScheme.secondary,),
              PasswordTextFormField(hintText: 'Enter your new password', controller:passwordController ,),
              CustomText(text: 'Confirm New Password',color: Theme.of(context).colorScheme.secondary,),
              PasswordTextFormField(hintText: 'Re-enter your new password', controller:confirmPasswordController, ),
              CustomButton(
                  onPressed: (){
                    Navigator.push(context,  CupertinoPageRoute(builder: (context)=>SignInView()));
                  },
                  text: "Reset Password",
                  color:Theme.of(context).colorScheme.primary,
                  borderColor: Theme.of(context).colorScheme.primary,
              ),

          ],),
        ),
      ),
    );
  }
}
