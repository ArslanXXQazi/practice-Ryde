
import 'package:flutter/cupertino.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';
import 'package:practice_ryde/src/view/authviews/signinview/sign_in_controller.dart';

class SignInView extends StatefulWidget {
  SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {

  final _formField=GlobalKey<FormState> ();
  SignInController signInController=Get.put(SignInController());

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
                child: BoldText(text: 'Log In',color: Theme.of(context).colorScheme.secondary,),
              ),
              Form(
                key: _formField,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                CustomText(text: 'Email',color: Theme.of(context).colorScheme.secondary),
                CustomTextFormField(hintText: 'Enter your email', controller: signInController.emailController),
                CustomText(text: 'Password',color: Theme.of(context).colorScheme.secondary),
                PasswordTextFormField(hintText: 'Enter your password', controller: signInController.passwordController),
              ],)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,  CupertinoPageRoute(builder: (context)=>ForgotPasswordView()));
                    },
                      child: CustomText(text: "Forgot Password?",color: Theme.of(context).colorScheme.secondary)),
              ],),
              Obx(()=>
                  CustomButton(
                    loading: signInController.loading.value,
                    onPressed: (){
                      if(_formField.currentState!.validate()){
                        signInController.signIn(context);
                      }
                    },
                    text: 'Log in',
                    color: Theme.of(context).colorScheme.primary,
                    borderColor: Theme.of(context).colorScheme.primary,
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: "Don’t have an account?",color: Theme.of(context).colorScheme.secondary),
                  TextButton(
                    onPressed: (){
                      Navigator.push(context,  CupertinoPageRoute(builder: (context)=>SignUpView()));
                    },
                    child: BoldText(text: 'Sign up',fontSize: 16,color: Theme.of(context).colorScheme.secondary),
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
                  onPressed:(){},
                  image: Appimages.apple,
                  text: "Continue with Apple",
              ),
            ],),
        ),
      ),
    );
  }
}
