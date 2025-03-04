import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailVerificationScreen extends StatefulWidget {
  final User user;
  const EmailVerificationScreen({Key? key, required this.user}) : super(key: key);

  @override
  _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    await widget.user.reload(); // Refresh Firebase user data
    if (widget.user.emailVerified) {
      _timer.cancel();
      Get.offAllNamed('/home');  // Replace with your Home Screen route
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify Email')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('A verification email has been sent to ${widget.user.email}.'),
            SizedBox(height: 10),
            Text('Please check your email and verify your account.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: checkEmailVerified,
              child: Text('I have verified'),
            ),
          ],
        ),
      ),
    );
  }
}
