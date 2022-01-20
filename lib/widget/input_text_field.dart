import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    Key? key,
    required this.controller,
    this.obscure = false,
    required this.hintText,
    required this.icon,
    this.emailValidation = false,
    this.passwordValidation = false,
  }) : super(key: key);

  final TextEditingController controller;
  final bool obscure;
  final bool emailValidation;
  final bool passwordValidation;
  final String hintText;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: emailValidation
          ? emailValidator
          : (passwordValidation ? passwordValidator : (_) => null),
      controller: controller,
      obscureText: obscure,
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintStyle: const TextStyle(color: Colors.white),
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        hintText: hintText,
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
      ),
    );
  }

  String? emailValidator(String? text) {
    RegExp exp = RegExp(r"^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$");

    return text == null
        ? null
        : (exp.hasMatch(text) ? null : "Invalid email address.");
  }

  String? passwordValidator(String? text) {
    return text == null
        ? null
        : (text.length < 8 ? "Password length must greater than or equal to 8." :null);
  }
}
