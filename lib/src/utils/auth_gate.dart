import 'package:coding_diary/src/constants/app_colors.dart';
import 'package:coding_diary/src/screens/home/home_screen.dart';
import 'package:coding_diary/src/screens/splash/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return StreamBuilder(
      stream: auth.authStateChanges(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(color: AppColors.ink,),
          );
        } else{
          if (snapshot.hasData){
            return HomeScreen();
          } else{
            return SplashScreen();
          }
        }
      },
      );
  }
}