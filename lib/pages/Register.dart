// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/Shared/snackbar';

import '../Shared/Constant.dart';
import '../Shared/myColors.dart';
import 'Login.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool isVisable = false;

  bool has8Charachter = false;
  bool hasLowerCase = false;
  bool hasUpperCase = false;
  bool has1Number = false;
  bool hasSpecialCharachter = false;

  onPasswordChanged(String password) {
    has8Charachter = false;
    hasLowerCase = false;
    hasUpperCase = false;
    has1Number = false;
    hasSpecialCharachter = false;
    setState(() {
      if (password.contains(RegExp(r'.{8,}'))) {
        has8Charachter = true;
      }

      if (password.contains(RegExp(r'[a-z]'))) {
        hasLowerCase = true;
      }

      if (password.contains(RegExp(r'[A-Z]'))) {
        hasUpperCase = true;
      }

      if (password.contains(RegExp(r'[0-9]'))) {
        has1Number = true;
      }

      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        hasSpecialCharachter = true;
      }
    });
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  createAccount() async {
    setState(() {
      isLoading = true;
    });
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, "The account already exists for that email.");
      } else {
        showSnackBar(context, "${e.code} error");
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: textFieldDecsoration.copyWith(
                            hintText: "Enter Your username : ",
                            suffix: Icon(Icons.person))),
                    const SizedBox(
                      height: 33,
                    ),
                    TextFormField(
                        validator: (value) {
                          return isEmail(value!)
                              ? null
                              : "enter VAlidate email";
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        onChanged: (password) {
                          onPasswordChanged(password);
                        },
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: isVisable ? true : false,
                        decoration: textFieldDecsoration.copyWith(
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
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: has8Charachter
                                    ? Colors.green
                                    : Colors.white,
                                border: Border.all(color: Colors.grey)),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            )),
                        SizedBox(
                          width: 14,
                        ),
                        Text("At least 8 characters")
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: has1Number ? Colors.green : Colors.white,
                                border: Border.all(color: Colors.grey)),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            )),
                        SizedBox(
                          width: 14,
                        ),
                        Text("At least 1 number")
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    hasUpperCase ? Colors.green : Colors.white,
                                border: Border.all(color: Colors.grey)),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            )),
                        SizedBox(
                          width: 14,
                        ),
                        Text("Has Upper Case")
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    hasLowerCase ? Colors.green : Colors.white,
                                border: Border.all(color: Colors.grey)),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            )),
                        SizedBox(
                          width: 14,
                        ),
                        Text("Has Lower Case")
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: hasSpecialCharachter
                                    ? Colors.green
                                    : Colors.white,
                                border: Border.all(color: Colors.grey)),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            )),
                        SizedBox(
                          width: 14,
                        ),
                        Text("Has Special Characters")
                      ],
                    ),
                    const SizedBox(
                      height: 33,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate() &&
                            hasLowerCase &&
                            hasUpperCase &&
                            has1Number &&
                            hasSpecialCharachter) {
                          await createAccount();
                          if (!mounted) return;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        } else {
                          showSnackBar(context, "Check Your Data");
                        }
                      },
                      child: isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              "Register",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("have an account?",
                            style: TextStyle(fontSize: 18)),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                            child: Text('Log in',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18))),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
