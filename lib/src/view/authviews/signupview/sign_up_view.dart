import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice_ryde/src/utils/utils.dart';
import 'package:toastification/toastification.dart';



class SignUpView extends StatefulWidget {
  SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {

  SignUpController signupcontroller = Get.put(SignUpController());
bool loading=false;
TextEditingController nameController=TextEditingController();
TextEditingController passwordController=TextEditingController();
TextEditingController emailController=TextEditingController();

 FirebaseAuth _auth=FirebaseAuth.instance;

 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
  }

  void signUp()
  {
    setState(() {
      loading=true;
    });
    _auth.createUserWithEmailAndPassword(email: emailController.text.toString(), password: passwordController.text.toString()).then((value){
      setState(() {
        loading=false;
      });
      Utils().toastMsg(
          "Sign Up Successfully",
          context,
          Theme.of(context).colorScheme.background,
          ToastificationType.success
      );
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      Navigator.push(context,  CupertinoPageRoute(builder: (context)=>SignInView()));
    }).onError((e,catcherror){
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
                child: BoldText(text: 'Sign Up',color: Theme.of(context).colorScheme.secondary,),
              ),
              CustomText(text: 'Your Name',color: Theme.of(context).colorScheme.secondary),
              CustomTextFormField(hintText: 'Enter your name', controller: nameController),
              CustomText(text: 'Email or Phone',color: Theme.of(context).colorScheme.secondary),
              CustomTextFormField(hintText: 'Enter your or phone number', controller: emailController),
              CustomText(text: 'Password',color: Theme.of(context).colorScheme.secondary),
              PasswordTextFormField(hintText: 'Create a password', controller:passwordController),
              CustomButton(
                loading: loading,
                onPressed: ()
                {
                  signUp();
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
