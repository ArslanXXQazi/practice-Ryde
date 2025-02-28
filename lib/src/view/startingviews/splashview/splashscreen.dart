import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:practice_ryde/src/controllers/constants/linker.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      login();
    });
  }

  void login() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (mounted) {
      if (user != null) {
        Navigator.pushReplacement(
            context, CupertinoPageRoute(builder: (context) => NavBarView()));
      } else {
        Navigator.pushReplacement(
            context, CupertinoPageRoute(builder: (context) => SignInView()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: ImageIcon(
          AssetImage(Appimages.appLogo),
          size: width * .3,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
