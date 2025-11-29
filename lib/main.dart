import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocketlab/CertificateScreen/CompletionCertificateScreen.dart';
import 'package:pocketlab/Forgotpasswordscreen/Forgotpasswordscreen.dart';
import 'package:pocketlab/bottombarscreen/bottombar.dart';
import 'package:pocketlab/loginsignupscreen/login_signupscreen.dart';
import 'package:pocketlab/splashscreen/splashscreen.dart';

import 'dashboardscreen/dashboardscreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (context, child) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      fontFamily: "Lato",
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    ),
    home: MainBottomBar(),
    );
    }
    );
  }
}

