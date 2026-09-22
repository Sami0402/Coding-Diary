import 'package:coding_diary/src/constants/app_colors.dart';
import 'package:coding_diary/src/constants/asset_constant.dart';
import 'package:coding_diary/src/constants/typography.dart';
import 'package:coding_diary/src/constants/validatrions.dart';
import 'package:coding_diary/src/providers/auth_provider.dart';
import 'package:coding_diary/src/services/auth_service.dart';
import 'package:coding_diary/src/widgets/custom_solid_button.dart';
import 'package:coding_diary/src/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController email = TextEditingController();

    final provider = context.read<AuthProvider>();
    void onTap() async {
      if (formKey.currentState!.validate()) {
        provider.resetPassword(email: email.text);
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
            child: Column(
              children: [
                // BACK BUTTON
                Align(
                  alignment: AlignmentGeometry.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      AuthService.emailError = null;
                    provider.stopTimer();

                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.inkFaint.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.keyboard_backspace,
                        size: 20,
                        color: AppColors.ink,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 35),

                // TITLE
                Align(
                  alignment: AlignmentGeometry.topLeft,
                  child: RichText(
                    text: TextSpan(
                      text: 'Reset your ',
                      style: TypographyFraunces.displayLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: 'password',
                          style: TypographyFraunces.displayLarge.copyWith(
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.italic,
                            color: AppColors.amber,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // SUB-TITL
                Align(
                  alignment: AlignmentGeometry.topLeft,
                  child: Text(
                    "We'll send a reset link to your email",
                    style: TypographyInstrumentSans.caption.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.inkMuted.withValues(alpha: 0.8),
                    ),
                  ),
                ),
                SizedBox(height: 35),

                // INFO - YELLOW CONTAINER
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.amberLight,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: .start,
                    children: [
                      // ICON
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: SizedBox(
                          height: 22,
                          child: SvgPicture.asset(AssetConstant.buldIcon),
                        ),
                      ),
                      SizedBox(width: 12),
                      // TEXT
                      Text(
                        "Enter Email associated with your\nCodingDiary account and we'll send you a\n reset link within a minute.",
                        style: TypographyInstrumentSans.caption.copyWith(
                          fontSize: 13.5,
                          color: AppColors.amberDark,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),

                // EMAIL -TEXTFEILD
                Consumer<AuthProvider>(
                  builder: (context, auth, child) {
                    return Form(
                      key: formKey,
                      child: CustomTextField(
                        label: 'Email',
                        hintText: 'Your email',
                        controller: email,
                        validator: Validators.email,
                        errorText: AuthService.emailError,
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),

                // RESEND RESET LINK - BUTTON
                Consumer<AuthProvider>(
                  builder: (context, auth, child) {
                    return CustomSolidButton(
                      text: 'Resend Reset Link',
                      onTap: provider.isResetActive ? onTap : null,
                      backgroundColor: provider.isResetActive
                          ? AppColors.ink
                          : AppColors.inkMuted,
                    );
                  },
                ),
                SizedBox(height: 22),

                // BACK TO SIGN IN - BUTTON
                CustomSolidButton(
                  backgroundColor: AppColors.background,
                  border: Border.all(color: AppColors.borders),
                  text: 'Back to Sign In',
                  textStyle: TypographyInstrumentSans.caption,
                  onTap: () {
                    Navigator.pop(context);
                    AuthService.emailError = null;
                    provider.stopTimer();
                  },
                ),
                SizedBox(height: 25),

                // DID'nt RECIEVE EMAIL - CONATINER
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: AppColors.inkFaint.withValues(alpha: 0.30),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      // TEXT
                      Text(
                        "Did'nt receive an email?",
                        style: TypographyDMMono.caption.copyWith(
                          fontSize: 13.0,
                          color: AppColors.inkMuted,
                        ),
                      ),

                      SizedBox(height: 8),
                      // TEXT
                      Selector<AuthProvider, int>(
                        selector: (context, p) => p.remainingTime,
                        builder: (context, remainingTime, child) {
                          return RichText(
                            text: TextSpan(
                              text:
                                  "Check your spam folder or make sure you\nused the right email address. You can resend\nin ",
                              style: TypographyInstrumentSans.caption.copyWith(
                                fontSize: 13.5,
                                height: 1.5,
                                color: AppColors.inkSoft,
                              ),
                              children: [
                                TextSpan(
                                  text: "${remainingTime}s",
                                  style: TypographyInstrumentSans.caption
                                      .copyWith(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.amber,
                                      ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
