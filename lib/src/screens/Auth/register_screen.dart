import 'package:coding_diary/routes.dart';
import 'package:coding_diary/src/constants/app_colors.dart';
import 'package:coding_diary/src/constants/typography.dart';
import 'package:coding_diary/src/constants/validatrions.dart';
import 'package:coding_diary/src/providers/auth_provider.dart';
import 'package:coding_diary/src/services/auth_service.dart';
import 'package:coding_diary/src/widgets/custom_solid_button.dart';
import 'package:coding_diary/src/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController fullName = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    fullName.dispose();
    username.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final auth = context.read<AuthProvider>();

    Future<void> handleRegistration() async {
      if (formKey.currentState!.validate()) {
        final isRegistered = await context.read<AuthProvider>().register(
          fullName: fullName.text,
          username: username.text,
          email: email.text,
          password: password.text,
        );

        // if widget is removed from the tree
        if (!context.mounted) return;

        if (isRegistered) {
          Navigator.popAndPushNamed(context, AppRoute.home);
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
                      onTap: () {
                        Navigator.pop(context);
                        auth.clearErrorText();
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
                        text: 'Create your ',
                        style: TypographyFraunces.displayLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: 'diary',
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
                      'Start documenting your dev journey today',
                      style: TypographyInstrumentSans.caption.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.inkMuted.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                  SizedBox(height: 35),

                  // FULL NAME -TEXTFEILD
                  Consumer<AuthProvider>(
                    builder: (context, auth, child) {
                      return CustomTextField(
                        label: 'Full Name',
                        hintText: 'Your name',
                        controller: fullName,
                        validator: Validators.fullName,
                      );
                    },
                  ),
                  SizedBox(height: 20),

                  // EMAIL - TEXTFIELD
                  Consumer<AuthProvider>(
                    builder: (context, auth, child) {
                      return CustomTextField(
                        label: 'Email',
                        hintText: 'Your email',
                        controller: email,
                        validator: Validators.email,
                        errorText: AuthService.emailError,
                      );
                    },
                  ),
                  SizedBox(height: 16),

                  // USERNAME - TEXTFIELD
                  Selector<AuthProvider, String?>(
                    selector: (context, auth) => auth.usernameError,
                    builder: (context, usernameError, child) {
                      return CustomTextField(
                        label: 'Username',
                        hintText: 'Your username',
                        controller: username,
                        onChanged: auth.checkUsername,
                        validator: Validators.username,
                        errorText: usernameError,
                      );
                    },
                  ),
                  SizedBox(height: 16),

                  // PASSWORD - TEXTFIELD
                  Consumer<AuthProvider>(
                    builder: (context, auth, child) {
                      return CustomTextField(
                        label: 'Password',
                        hintText: 'Your passowrd',
                        controller: password,
                        validator: Validators.password,
                        obscureText: true,
                      );
                    },
                  ),

                  SizedBox(height: 16),

                  // CREATE ACCOUNT - BUTTON
                  CustomSolidButton(
                    onTap: () async {
                      await handleRegistration();
                    },

                    child: Consumer<AuthProvider>(
                      builder: (context, auth, child) {
                        if (auth.isLoading) {
                          return CircularProgressIndicator(
                            color: AppColors.background,
                          );
                        }
                        return Text(
                          'Create Account',
                          style: TypographyInstrumentSans.label.copyWith(
                            color: AppColors.background,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 22),

                  // Privacy Policy.... - NAVIGATOR
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "By signing up you agree to our ",
                      style: TypographyInstrumentSans.caption.copyWith(
                        height: 1.5,
                        fontSize: 12,
                        color: AppColors.inkMuted,
                      ),
                      children: [
                        TextSpan(
                          text: 'Terms of Service ',
                          style: TypographyInstrumentSans.caption.copyWith(
                            fontSize: 12,
                            color: AppColors.amber,
                          ),
                        ),
                        TextSpan(
                          text: 'and ',
                          style: TypographyInstrumentSans.caption.copyWith(
                            fontSize: 12,
                            color: AppColors.inkMuted,
                          ),
                        ),
                        TextSpan(
                          text: '\nPrivacy Policy',
                          style: TypographyInstrumentSans.caption.copyWith(
                            fontSize: 12,
                            color: AppColors.amber,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TypographyInstrumentSans.caption.copyWith(
                        fontSize: 15,
                        color: AppColors.inkMuted,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign in',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.popAndPushNamed(
                                context,
                                AppRoute.login,
                              );
                              auth.clearErrorText();
                            },

                          style: TypographyInstrumentSans.caption.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.amber,
                          ),
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
