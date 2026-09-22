import 'package:coding_diary/routes.dart';
import 'package:coding_diary/src/constants/app_colors.dart';
import 'package:coding_diary/src/constants/asset_constant.dart';
import 'package:coding_diary/src/constants/onbaording_data.dart';
import 'package:coding_diary/src/constants/typography.dart';
import 'package:coding_diary/src/providers/auth_provider.dart';
import 'package:coding_diary/src/screens/onboarding/widgets/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          children: [
            // SKIP & STEPS
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 20,
              ).copyWith(top: 30),

              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, AppRoute.login),
                    child: Text(
                      'Skip',
                      style: TypographyDMMono.caption.copyWith(
                        fontSize: 16,
                        color: AppColors.inkMuted.withValues(alpha: 0.6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '${provider.currentIndex + 1} of 3',
                    style: TypographyDMMono.caption.copyWith(
                      fontSize: 16,
                      color: AppColors.inkFaint,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),

            // Progress Bar
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 14,
                top: 15,
                bottom: 10,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(3, (index) {
                  return Expanded(
                    child: Container(
                      height: 4,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: index == provider.currentIndex
                            ? AppColors.amberMid.withValues(alpha: 0.5)
                            : index < provider.currentIndex
                            ? AppColors.amber
                            : AppColors.inkFaint,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 40),

            // CONTENT
            Expanded(
              child: PageView.builder(
                controller: context.read<AuthProvider>().pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  final content = OnbaordingData.content[index];
                  return OnboardingPage(
                    icon: content['Icon']!,
                    firstText: content["firstText"]!,
                    italicText: content["italicText"]!,
                    lastText: content["lastText"]!,
                    subTitle: content["subTitle"]!,
                    backButton: index > 0 ? true : false,
                    lastPage: index == 2 ? true : false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
