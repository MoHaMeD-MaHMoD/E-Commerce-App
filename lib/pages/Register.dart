// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Shared/Constant.dart';
import 'package:e_commerce_app/Shared/myColors.dart';
import 'package:e_commerce_app/pages/EmailVirify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/Shared/snackbar';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'Login.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  File? imgPath;

  bool isLoading = false;
  bool isVisable = false;

  bool has8Charachter = false;
  bool hasLowerCase = false;
  bool hasUpperCase = false;
  bool has1Number = false;
  bool hasSpecialCharachter = false;


  
  showmodel() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(22),
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uploadImage2Screen(ImageSource.camera);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.camera,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Camera",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () {
                  uploadImage2Screen(ImageSource.gallery);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.photo_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Gallery",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();
  final titleController = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables

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
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      users
          .doc(credential.user!.uid)
          .set({
            'Email': emailController.text,
            'Password': passwordController.text,
            'UserName': userNameController.text,
            'Phone': phoneController.text,
            'Age': ageController.text,
            'Title': titleController.text
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
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

  uploadImage2Screen(ImageSource imageSource) async {
    final pickedImg = await ImagePicker().pickImage(source: imageSource);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }

    if (!mounted) return;
    Navigator.pop(context);
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbar,
        title: Text("Sign up"),
      ),
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
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(125, 78, 91, 110),
                    ),
                    child: Stack(
                      children: [
                        imgPath == null
                            ? CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 225, 225, 225),
                                radius: 71,
                                // backgroundImage: AssetImage("assets/img/avatar.png"),
                                backgroundImage:
                                    AssetImage("assets/img/avatar.png"),
                              )
                            : ClipOval(
                                child: Image.file(
                                  imgPath!,
                                  width: 145,
                                  height: 145,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        Positioned(
                          left: 95,
                          bottom: -10,
                          child: IconButton(
                            onPressed: () {
                              showmodel() ;
                            },
                            icon: const Icon(Icons.add_a_photo),
                            color: Color.fromARGB(255, 94, 115, 128),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  TextField(
                      controller: userNameController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: textFieldDecsoration.copyWith(
                          hintText: "Enter Your username : ",
                          suffix: Icon(Icons.person))),
                  const SizedBox(
                    height: 22,
                  ),
                  TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      decoration: textFieldDecsoration.copyWith(
                          hintText: "Enter Your phone : ",
                          suffixIcon: Icon(Icons.phone))),
                  const SizedBox(
                    height: 22,
                  ),
                  TextFormField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      decoration: textFieldDecsoration.copyWith(
                          hintText: "Enter Your age : ",
                          suffixIcon: Icon(Icons.abc))),
                  const SizedBox(
                    height: 22,
                  ),
                  TextFormField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: textFieldDecsoration.copyWith(
                          hintText: "Enter Your title : ",
                          suffixIcon: Icon(Icons.person_outline))),
                  const SizedBox(
                    height: 22,
                  ),
                  TextFormField(
                      validator: (value) {
                        return isEmail(value!) ? null : "enter VAlidate email";
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: textFieldDecsoration.copyWith(
                          hintText: "Enter Your Email : ",
                          suffix: Icon(Icons.email))),
                  const SizedBox(
                    height: 22,
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
                              color:
                                  has8Charachter ? Colors.green : Colors.white,
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
                              color: hasUpperCase ? Colors.green : Colors.white,
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
                              color: hasLowerCase ? Colors.green : Colors.white,
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
                      Text("have an account?", style: TextStyle(fontSize: 18)),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
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
    );
  }
}
