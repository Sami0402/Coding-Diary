import 'package:coding_diary/src/constants/app_colors.dart';
import 'package:coding_diary/src/constants/typography.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.validator,
    this.errorText, this.onChanged,  this.obscureText = false,
  });

  final String label;
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? errorText;
  final void Function(String)? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  Color borderColor = AppColors.cards;
  List<BoxShadow> boxShadow = [];
  Color backgroundColor = AppColors.darkCream;

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {
        if (_focusNode.hasFocus) {
          borderColor = AppColors.amber;
          boxShadow = [
            BoxShadow(
              blurRadius: 3.0,
              color: AppColors.amberMid,
              offset: Offset(0, 0),
            ),
          ];
          backgroundColor = AppColors.cards;
        } else {
          borderColor = AppColors.cards;
          boxShadow = [];
          backgroundColor = AppColors.darkCream;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(15),
        boxShadow: boxShadow,
      ),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisAlignment: .center,
        children: [
          // LABEL
          Padding(
            padding: const EdgeInsets.only(left: 22.0, top: 15.0),
            child: Text(
              widget.label,
              style: TypographyDMMono.caption.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: AppColors.inkMuted.withValues(alpha: 0.8),
              ),
            ),
          ),
          // TEXTFIELD
          TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            validator: widget.validator,
            onChanged: widget.onChanged,
            onTapUpOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            obscureText: widget.obscureText,
            decoration: InputDecoration(
              errorText: widget.errorText,
              errorStyle: TypographyInstrumentSans.caption.copyWith(
                fontSize: 12,
                color: AppColors.rose.withValues(alpha: 0.8),
                fontStyle: FontStyle.italic,
              ),
              contentPadding: EdgeInsets.only(left: 20.0, bottom: 20.0),
              hintText: widget.hintText,
              hintStyle: TypographyInstrumentSans.caption.copyWith(
                fontSize: 16,
                color: AppColors.inkMuted.withValues(alpha: 0.7),
                fontStyle: FontStyle.italic,
              ),
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }
}
