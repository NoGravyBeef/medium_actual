import 'package:flutter/material.dart';
import 'package:medium_actual/common/const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.autofocus = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(color: INPUT_BORDER_COLOR, width: 1.0),
    );

    return TextFormField(
      onChanged: onChanged,
      cursorColor: PRIMARY_COLOR,
      // 비밀번호 적을 때
      obscureText: obscureText,
      autofocus: autofocus,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        hintText: hintText,
        hintStyle: TextStyle(color: BODY_TEXT_COLOR, fontSize: 14),
        errorText: errorText,
        fillColor: INPUT_BG_COLOR,
        filled: true,
        // border: baseBorder,
        enabledBorder: baseBorder,
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(color: PRIMARY_COLOR),
        ),
      ),
    );
  }
}
