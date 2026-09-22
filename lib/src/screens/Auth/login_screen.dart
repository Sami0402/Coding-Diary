import 'package:coding_diary/routes.dart';
import 'package:coding_diary/src/constants/app_colors.dart';
import 'package:coding_diary/src/constants/asset_constant.dart';
import 'package:coding_diary/src/constants/typography.dart';
import 'package:coding_diary/src/constants/validatrions.dart';
import 'package:coding_diary/src/providers/auth_provider.dart';
import 'package:coding_diary/src/services/auth_service.dart';
import 'package:coding_diary/src/widgets/custom_solid_button.dart';
import 'package:coding_diary/src/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();

    final auth = context.read<AuthProvider>();

    void loginHandler() async {
      if (formKey.currentState!.validate()) {
        final userLoggedIn = await auth.login(
          email: email.text,
          password: password.text,
        );

        if (!context.mounted) return;

        if (userLoggedIn) {
          Navigator.pushReplacementNamed(context, AppRoute.home);
        }
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  // BACK BUTTON
                  Align(
                    alignment: AlignmentGeometry.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
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
                        text: 'Welcome ',
                        style: TypographyFraunces.displayLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: 'back',
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
                      'Sign in to continue your streak',
                      style: TypographyInstrumentSans.caption.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.inkMuted.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                  SizedBox(height: 35),

                  // EMAIL -TEXTFEILD
                  CustomTextField(
                    label: 'Email',
                    hintText: 'Your email',
                    controller: email,
                    validator: Validators.email,
                  ),
                  SizedBox(height: 20),

                  // PASSWORD - TEXTFIELD
                  CustomTextField(
                    label: 'Password',
                    hintText: 'Your Password',
                    controller: password,
                    obscureText: true,
                  ),
                  SizedBox(height: 12),

                  Consumer<AuthProvider>(
                    builder: (context, auth, child) {
                      if (AuthService.commonError != null) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            AuthService.commonError!,
                            textAlign: TextAlign.left,
                            style: TypographyInstrumentSans.caption.copyWith(
                              fontSize: 12,
                              color: AppColors.rose.withValues(alpha: 0.8),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),

                  // FORGOT PASSWORD
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoute.forgotPassword),
                      child: Text(
                        'Forgot password?',
                        style: TypographyDMMono.caption.copyWith(
                          color: AppColors.amber,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),

                  // SIGN IN - BUTTON
                  CustomSolidButton(
                    onTap: loginHandler,
                    child: Consumer<AuthProvider>(
                      builder: (context, auth, child) {
                        if (auth.isLoading) {
                          return CircularProgressIndicator(
                            color: AppColors.background,
                          );
                        }
                        return Text(
                          'Sign In',
                          style: TypographyInstrumentSans.label.copyWith(
                            color: AppColors.background,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 22),

                  // DIVIDER
                  Row(
                    crossAxisAlignment: .center,
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          'or continue with',
                          style: TypographyDMMono.caption.copyWith(
                            color: AppColors.inkMuted.withValues(alpha: 0.5),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(height: 22),

                  // CONTINUE WITH GOOGLE - BUTTON
                  CustomSolidButton(
                    backgroundColor: AppColors.background,
                    border: Border.all(color: AppColors.borders),
                    onTap: () =>
                        context.read<AuthProvider>().signInWithGoogle(context),
                    child: Row(
                      mainAxisAlignment: .center,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints.tight(Size(25, 25)),
                          child: SvgPicture.asset(
                            AssetConstant.googleIcon,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(width: 18),
                        Text(
                          'Continue with Google',
                          style: TypographyInstrumentSans.caption,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),

                  // Don't have account.... - NAVIGATOR
                  RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TypographyInstrumentSans.caption.copyWith(
                        fontSize: 15,
                        color: AppColors.inkMuted,
                      ),
                      children: [
                        TextSpan(
                          text: 'Create one',
                          style: TypographyInstrumentSans.caption.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.amber,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, AppRoute.register);
                              AuthService.commonError = null;
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
      ),
    );
  }
}
