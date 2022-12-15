import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';

class ReusableTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final TextInputType textInputType;
  final TextInputAction actionKeyboard;
  final String textValidate;
  final bool? obscureText;
  const ReusableTextFormField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    required this.textInputType,
    required this.actionKeyboard,
    required this.textValidate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, bottom: 0, left: 29, right: 29),
      child: TextFormField(
        obscureText: obscureText==true?true:false,
        
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(29),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(29),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(29),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(29),
            borderSide: const BorderSide(width: 2, color: Colors.redAccent),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(29),
            borderSide: const BorderSide(width: 2, color: Colors.redAccent),
          ),
          fillColor: kPrimaryLightColor,
          filled: true,
        
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 20,
            letterSpacing: 0.5,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
        keyboardType: textInputType,
        textInputAction: actionKeyboard,
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return textValidate;
          } else {
            return null;
          }
        },
      ),
    );
  }
}
