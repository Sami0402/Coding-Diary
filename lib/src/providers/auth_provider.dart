import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coding_diary/routes.dart';
import 'package:coding_diary/src/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _auth = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? usernameError;
  bool isLoading = false;

  // ON-BOARDING
  final PageController pageController = PageController();
  int currentIndex = 0;

  void nextPage() {
    if (currentIndex < 2) {
      currentIndex += 1;
      pageController.jumpToPage(currentIndex);
    }
    notifyListeners();
  }

  void prevousPage() {
    if (currentIndex > 0) {
      currentIndex -= 1;
      pageController.jumpToPage(currentIndex);
    }
    notifyListeners();
  }

  // REGISTER
  Future<bool> register({
    required String fullName,
    required String username,
    required String email,
    required String password,
  }) async {
    isLoading = true;
    notifyListeners();
    final result = await _auth.registerUser(
      fullName: fullName,
      username: username,
      email: email,
      password: password,
    );

    if (result == 'Success') {
      return true;
    }
    isLoading = false;
    notifyListeners();
    return false;
  }

  Future<void> checkUsername(String value) async {
    String enterdUsername = value.trim().toLowerCase();
    if (enterdUsername.isEmpty) enterdUsername = "_";
    final usernameEntry = await _firestore
        .collection('usernames')
        .doc(enterdUsername)
        .get();

    if (usernameEntry.exists) {
      usernameError = 'Username already exist';
      AuthService.userNameExist = true;
      notifyListeners();
    } else {
      usernameError = null;
      AuthService.userNameExist = false;
      notifyListeners();
    }
  }

  void clearErrorText() {
    usernameError = null;
    AuthService.emailError = null;
  }

  // LOGIN
  Future<bool> login({required String email, required String password}) async {
    isLoading = true;
    notifyListeners();

    final result = await _auth.loginUser(email: email, password: password);
    isLoading = false;
    notifyListeners();
    if (result == 'Success') {
      return true;
    } else {
      return false;
    }
  }

  // RESET PASSWORD
  bool isResetActive = true;
  int remainingTime = 45;
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime -= 1;
        notifyListeners();
      } else {
        isResetActive = true;
        timer.cancel();
        notifyListeners();
      }
    });
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      remainingTime = 45;
      isResetActive = true;
    }
  }

  void timerHandler() {
    isResetActive = false;
    notifyListeners();
    startTimer();
    remainingTime = 45;
  }

  Future<void> resetPassword({required String email}) async {
    await _auth.resetPassword(email: email);
    if (AuthService.emailError == null) timerHandler();
    notifyListeners();
  }


  // SIGN-IN WITH GOOGLE
  Future<void> signInWithGoogle(BuildContext context) async{
   final success = await _auth.signInWithGoogle();

    if (!context.mounted) return;

   if (success){
    Navigator.popAndPushNamed(context, AppRoute.home);
   }
  }
}
