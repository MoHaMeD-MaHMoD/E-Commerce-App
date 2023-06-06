// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final bool obscureText;
  final String hintText;
  //TextInputType.emailAddress
  const MyTextField(
      {super.key,
      required this.keyboardType,
      required this.obscureText,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      // delete Border
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: Divider.createBorderSide(context),
        ),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        filled: true,
        contentPadding: EdgeInsets.all(8),
      ),
    );
  }
}
