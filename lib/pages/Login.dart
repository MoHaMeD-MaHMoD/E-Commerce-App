// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:e_commerce_app/Shared/Constant.dart';
import 'package:e_commerce_app/pages/Register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Shared/myColors.dart';
import '../Shared/snackbar';
import 'forgot_passowrd.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  bool isVisable = false;
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  logIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      // showSnackBar(context, "doneee");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, "Wrong password provided for that user.");
      } else
        showSnackBar(context, "${e.code} error");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 247, 247, 247),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 64,
                  ),
                  TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: textFieldDecsoration.copyWith(
                          hintText: "Enter Your Email : ",
                          suffix: Icon(Icons.email))),
                  const SizedBox(
                    height: 33,
                  ),
                  TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: isVisable ? true : false,
                      decoration: textFieldDecsoration.copyWith(
                          //textFieldDecsoration
                          hintText: "Enter Your Password : ",
                          suffix: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisable = !isVisable;
                                });
                              },
                              icon: isVisable
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off)))),
                  const SizedBox(
                    height: 33,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      logIn();
                    },
                    child: isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            "Sign in",
                            style: TextStyle(fontSize: 19),
                          ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(BTNColor),
                      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPassword()),
                      );
                    },
                    child: Text("Forgot password?",
                        style: TextStyle(
                            fontSize: 18, decoration: TextDecoration.underline)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Do not have an account?",
                          style: TextStyle(fontSize: 18)),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Register()),
                            );
                          },
                          child: Text('sign up',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18))),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
