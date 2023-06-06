// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../Shared/MyTextField.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 64,
              ),
              MyTextField(
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  hintText: "Enter Your Email"),
              MyTextField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  hintText: "Enter Your Password"),
            ],
          ),
        ),
      ),
    );
  }
}
