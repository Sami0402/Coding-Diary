import 'package:coding_diary/src/screens/Auth/forgot_password_screen.dart';
import 'package:coding_diary/src/screens/Auth/login_screen.dart';
import 'package:coding_diary/src/screens/Auth/register_screen.dart';
import 'package:coding_diary/src/screens/home/home_screen.dart';
import 'package:coding_diary/src/screens/onboarding/onboarding_screen.dart';
import 'package:coding_diary/src/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static const String splash = '/splash_screen';
  static const String onboard = '/onboard_screen';
  static const String login = '/login';
  static const String forgotPassword = '/forgot_password';
  static const String register = '/register';
  static const String home = '/home';

  static Map<String, WidgetBuilder> routes = {
    splash:(context) => SplashScreen(),
    onboard:(context) => OnboardingScreen(),
    login:(context) => LoginScreen(),
    forgotPassword:(context) => ForgotPassword(),
    register:(context) => RegisterScreen(),
    home:(context) => HomeScreen(),
  };
}