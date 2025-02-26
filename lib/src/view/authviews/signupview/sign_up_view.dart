import 'package:flutter/cupertino.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';
class SignUpView extends StatefulWidget {
  SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {

  SignUpController signupcontroller = Get.put(SignUpController());

// TextEditingController nameController=TextEditingController();
//
// TextEditingController passwordController=TextEditingController();
//
// TextEditingController emailController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width;
    final height=MediaQuery.sizeOf(context).height;
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: height*.07,horizontal: width*.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image(image: AssetImage(Appimages.appLogo),color: Theme.of(context).colorScheme.secondary,)),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: height*.02),
                child: BoldText(text: 'Sign Up',color: Theme.of(context).colorScheme.secondary,),
              ),
              CustomText(text: 'Your Name',color: Theme.of(context).colorScheme.secondary),
              CustomTextFormField(hintText: 'Enter your name', controller: signupcontroller.nameController),
              CustomText(text: 'Email or Phone',color: Theme.of(context).colorScheme.secondary),
              CustomTextFormField(hintText: 'Enter your or phone number', controller: signupcontroller.emailController),
              CustomText(text: 'Password',color: Theme.of(context).colorScheme.secondary),
              PasswordTextFormField(hintText: 'Create a password', controller:signupcontroller.passwordController),
              CustomButton(
                onPressed: ()
                {
                  Navigator.push(context,  CupertinoPageRoute(builder: (context)=>SignInView()));
                },
                text: 'Sign Up',
                color:Theme.of(context).colorScheme.primary,
                borderColor: Theme.of(context).colorScheme.primary,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                CustomText(text: "Already a member?",color: Theme.of(context).colorScheme.secondary),
                TextButton(
                    onPressed: (){
                      Navigator.push(context,  CupertinoPageRoute(builder: (context)=>SignInView()));
                    },
                    child: BoldText(text: 'Log in',fontSize: 16,color: Theme.of(context).colorScheme.secondary),
                ),
              ],),
              Padding(
                padding:  EdgeInsets.only(bottom: height*.01),
                child: Center(child: BoldText(text: 'Or',fontSize: 20,color: Theme.of(context).colorScheme.secondary)),
              ),
              SocialButton(
                  onPressed: (){},
                  image: Appimages.google,
                  text: "Continue with Google"
              ),
              SocialButton(
                  onPressed: (){},
                  image: Appimages.apple,
                  text: "Continue with Apple"
              )
            ],),
        ),
      ),
    );
  }
}
