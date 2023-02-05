import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_job_seeking/core/theme/app_color.dart';
import 'package:flutter_job_seeking/feature/Authentication/LoginPage.dart';
import 'package:flutter_job_seeking/feature/get_started/presentation/get_started_screen.dart';
import 'package:flutter_job_seeking/feature/home/presentation/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    new Future.delayed(
        const Duration(seconds: 3),
        () { 
          if(FirebaseAuth.instance.currentUser?.getIdToken() ==null){
        return Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GetStartedScreen()),
             
            );
          }else{
             return Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
             
            );
          }
  });
             
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      color: Colors.white,
      child: Center(child: Text("JOB.AI",style:GoogleFonts.monoton(fontSize: 40,color: AppColor.primaryColor)),),
    ),);
  }
}