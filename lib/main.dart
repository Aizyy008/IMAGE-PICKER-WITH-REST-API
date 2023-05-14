import 'package:flutter/material.dart';
import 'package:login_signup_postapi/login.dart';
import 'package:login_signup_postapi/sign_up.dart';
import 'package:login_signup_postapi/upload_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UploadImageScreen(),
    );

  }
}

