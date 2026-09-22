import 'package:coding_diary/src/constants/app_colors.dart';
import 'package:coding_diary/src/constants/typography.dart';
import 'package:flutter/material.dart';

class CustomSolidButton extends StatelessWidget {
  const CustomSolidButton({
    super.key,
    this.text,
    this.textStyle,
    this.backgroundColor,
    this.onTap,
    this.borderRadius,
    this.border,
    this.child,
  });

  final String? text;
  final Widget? child;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final double? borderRadius;
  final BoxBorder? border;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.ink,
          borderRadius: BorderRadius.circular(borderRadius ?? 20),
          border: border,
        ),
        child: Center(
          child:
              child ??
              Text(
                text!,
                textAlign: TextAlign.center,
                style:
                    textStyle ??
                    TypographyInstrumentSans.label.copyWith(
                      color: AppColors.background,
                      fontWeight: FontWeight.bold,
                    ),
              ),
        ),
      ),
    );
  }
}
