import 'package:e_commerce_app/Shared/Constant.dart';
import 'package:e_commerce_app/Shared/myColors.dart';
import 'package:e_commerce_app/Shared/snackbar';
import 'package:e_commerce_app/pages/Register.dart';
import 'package:e_commerce_app/pages/forgot_passowrd.dart';
import 'package:e_commerce_app/provider/google_signin.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVisable = false;
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  signIn() async {
    setState(() {
      isLoading = true;
    });

    try {
       await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR :  ${e.code} ");
    }

// Stop indicator
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbar,
        title: const Text("Sign in"),
      ),
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
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
                TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    decoration: textFieldDecsoration.copyWith(
                        hintText: "Enter Your Email : ",
                        suffixIcon: const Icon(Icons.email))),
                const SizedBox(
                  height: 33,
                ),
                TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: isVisable ? false : true,
                    decoration: textFieldDecsoration.copyWith(
                        hintText: "Enter Your Password : ",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisable = !isVisable;
                              });
                            },
                            icon: isVisable
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)))),
                const SizedBox(
                  height: 33,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await signIn();
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => VerifyEmailPage()),
                    // );
                    // showSnackBar(context, "Done ... ");
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(bTNColor),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          "Sign in",
                          style: TextStyle(fontSize: 19),
                        ),
                ),
                const SizedBox(
                  height: 9,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                    );
                  },
                  child: const Text("Forgot password?",
                      style: TextStyle(
                          fontSize: 18, decoration: TextDecoration.underline)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Do not have an account?",
                        style: TextStyle(fontSize: 18)),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                        child: const Text('sign up',
                            style: TextStyle(
                                fontSize: 18,
                                decoration: TextDecoration.underline))),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                const SizedBox(
                  width: 300,
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        height: 9,
                        thickness: .6,
                      )),
                      Text(
                        " OR ",
                        style: TextStyle(),
                      ),
                      Expanded(
                          child: Divider(
                        height: 9,
                        thickness: .6,
                      )),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: GestureDetector(
                    onTap: () {
                      googleSignInProvider.googlelogin();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(13),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/img/google.svg",
                        height: 64,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
