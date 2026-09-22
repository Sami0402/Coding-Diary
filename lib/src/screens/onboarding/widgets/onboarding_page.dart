import 'package:coding_diary/routes.dart';
import 'package:coding_diary/src/constants/app_colors.dart';
import 'package:coding_diary/src/constants/asset_constant.dart';
import 'package:coding_diary/src/constants/typography.dart';
import 'package:coding_diary/src/providers/auth_provider.dart';
import 'package:coding_diary/src/widgets/custom_solid_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.firstText,
    required this.italicText,
    required this.lastText,
    this.backButton = false,
    required this.icon,
    required this.subTitle, required this.lastPage,
  });

  final String icon;
  final String firstText;
  final String italicText;
  final String lastText;
  final String subTitle;
  final bool backButton;
  final bool lastPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        // ICON
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cards,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                blurRadius: 4.0,
                color: AppColors.inkFaint,
                offset: Offset(0, 1.5),
              ),
            ],
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(Size(60, 60)),
            child: SvgPicture.asset(icon),
          ),
        ),
        SizedBox(height: 35),

        // TITLE
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            // First - TEXTs
            text: firstText,

            style: TypographyFraunces.displayMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                // Italic Amber - TEXT
                text: italicText,
                style: TypographyFraunces.displayMedium.copyWith(
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.italic,
                  color: AppColors.amber,
                ),
              ),
              TextSpan(
                // Remaining - TEXTs
                text: lastText,
              ),
            ],
          ),
        ),
        SizedBox(height: 18),

        // TEXT
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TypographyInstrumentSans.caption.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16.5,
              color: AppColors.inkMuted.withValues(alpha: 0.7),
            ),
          ),
        ),
        Spacer(),

        // BUTTON
        backButton
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
                  children: [
                    CustomSolidButton(
                      text: lastPage ? 'Create My Diary' : 'Next',
                      onTap: () => lastPage ? Navigator.pushNamed(context, AppRoute.login) : context.read<AuthProvider>().nextPage(),
                    ),
                    SizedBox(height: 15),
                    CustomSolidButton(
                      text: 'Back',
                      onTap: () => context.read<AuthProvider>().prevousPage(),
                      textStyle: TypographyInstrumentSans.caption.copyWith(
                        color: AppColors.inkSoft,
                        fontWeight: FontWeight.w600,
                      ),
                      border: Border.all(color: AppColors.inkFaint),
                      backgroundColor: AppColors.background,
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: CustomSolidButton(
                  text: 'Next',
                  onTap: () => context.read<AuthProvider>().nextPage(),
                ),
              ),
        SizedBox(height: 35),
      ],
    );
  }
}
