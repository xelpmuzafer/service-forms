import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hint;
  final bool showText;
  final dynamic suffix;
  final TextEditingController controller;
  // ignore: prefer_typing_uninitialized_variables
  final validator;
  const CustomInput(
      {Key? key,
      required this.hint,
      required this.showText,
      this.suffix,
      required this.controller,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: showText == true ? false : true,
      decoration: InputDecoration(
        suffixIcon: suffix,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(84, 49, 43, 110)),
          borderRadius: BorderRadius.circular(10.7),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide:
              const BorderSide(color: Color.fromARGB(144, 255, 255, 255)),
          borderRadius: BorderRadius.circular(10.7),
        ),
        filled: true,
        fillColor: const Color.fromARGB(144, 255, 255, 255),
        border: const OutlineInputBorder(),
        hintText: hint,
      ),
    );
  }
}
