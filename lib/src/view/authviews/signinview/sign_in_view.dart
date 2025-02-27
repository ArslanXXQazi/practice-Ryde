import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';
import 'package:practice_ryde/src/utils/utils.dart';
import 'package:toastification/toastification.dart';

class SignInView extends StatefulWidget {
  SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {

  TextEditingController passwordController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  final _formField=GlobalKey<FormState> ();
  bool loading=false;
  FirebaseAuth _auth=FirebaseAuth.instance;

  void signIn() async
  {
    setState(() {
      loading=true;
    });
    await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text).then((value){
      setState(() {
        loading=false;
        Utils().toastMsg(
            "Login Successfully",
            context,
            Theme.of(context).colorScheme.background,
            ToastificationType.success
        );
        emailController.clear();
        passwordController.clear();
        Navigator.push(context, CupertinoPageRoute(builder: (context)=>NavBarView()));

      });

    }).onError((e,handlee) {
      setState(() {
        loading=false;
      });
      Utils().toastMsg(
          e.toString(),
          context,
          Theme.of(context).colorScheme.background,
          ToastificationType.error
      );
    });
  }



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
                CustomTextFormField(hintText: 'Enter your email', controller: emailController),
                CustomText(text: 'Password',color: Theme.of(context).colorScheme.secondary),
                PasswordTextFormField(hintText: 'Enter your password', controller: passwordController),
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
              CustomButton(
                loading: loading,
                onPressed: (){
                if(_formField.currentState!.validate()){
                  signIn();
                }
                },
                text: 'Log in',
                color: Theme.of(context).colorScheme.primary,
                borderColor: Theme.of(context).colorScheme.primary,
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
