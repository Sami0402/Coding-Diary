import 'dart:ui';

import 'package:coding_diary/routes.dart';
import 'package:coding_diary/src/constants/app_colors.dart';
import 'package:coding_diary/src/constants/typography.dart';
import 'package:coding_diary/src/screens/splash/widgets/floating_container.dart';
import 'package:coding_diary/src/widgets/custom_solid_button.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Circles in Background
          Positioned(
            top: -290.0,
            right: -105.0,
            left: -105.0,
            child: Container(
              padding: const EdgeInsets.all(70),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.inkFaint.withValues(alpha: 0.5),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(70),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.inkFaint.withValues(alpha: 0.5),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(260),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.inkFaint.withValues(alpha: 0.5),
                    ),
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 0.4,
                      colors: [
                        AppColors.amberLight.withValues(alpha: 0.4),
                        AppColors.background,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: double.infinity, width: double.infinity),

          // CONTENT
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26.0),
            child: Center(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  // ICON
                  FloatingContainer(),
                  SizedBox(height: 18),

                  // APP NAME
                  RichText(
                    text: TextSpan(
                      text: 'Coding',
                      style: TypographyFraunces.displayLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: 'Diary',
                          style: TypographyFraunces.displayLarge.copyWith(
                            color: AppColors.amber,
                            fontWeight: FontWeight.w100,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),

                  // TAG LINE
                  Text(
                    'Document your dev journey, one\nday at a time',
                    textAlign: TextAlign.center,
                    style: TypographyFraunces.caption.copyWith(
                      fontStyle: FontStyle.italic,
                      color: AppColors.inkMuted,
                    ),
                  ),
                  SizedBox(height: 50),

                  // GET STARTED - BUTTON
                  CustomSolidButton(
                    onTap: () => Navigator.pushReplacementNamed(
                      context,
                      AppRoute.onboard,
                    ),

                    text: 'Get Started',
                  ),
                  SizedBox(height: 20),

                  // I HAVE AN ACCOUNT - BUTTON
                  CustomSolidButton(
                    text: 'I have an account',
                    onTap: () => Navigator.pushNamed(context, AppRoute.login),
                    textStyle: TypographyInstrumentSans.caption.copyWith(
                      color: AppColors.ink,
                    ),
                    border: Border.all(color: AppColors.inkFaint),
                    backgroundColor: AppColors.background,
                  ),
                  SizedBox(height: 25),

                  // PRIVACY & POLICY
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'By Continuing you agree to our ',
                      style: TypographyDMMono.caption.copyWith(
                        fontSize: 12,
                        color: AppColors.inkFaint,
                      ),
                      children: [
                        TextSpan(
                          text: 'Terms ',
                          style: TypographyDMMono.caption.copyWith(
                            fontSize: 12,
                            color: AppColors.inkMuted,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(
                          text: '& ',
                          style: TypographyDMMono.caption.copyWith(
                            fontSize: 12,
                            color: AppColors.inkFaint,
                          ),
                        ),
                        TextSpan(
                          text: 'Privacy\nPolicy',
                          style: TypographyDMMono.caption.copyWith(
                            fontSize: 12,
                            color: AppColors.inkMuted,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
