// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import '../Shared/Constant.dart';
import '../Shared/myColors.dart';
import 'package:flutter/material.dart';
import '../Shared/snackbar';
import 'Login.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  resetPassword() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      showSnackBar(context, "Check Your Email Now");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "Error... ${e.code}");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
        elevation: 0,
        backgroundColor: appbar,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(33.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Enter your email to reset your password.",
                    style: TextStyle(fontSize: 18)),
                SizedBox(
                  height: 33,
                ),
                TextFormField(
                    // we return "null" when something is valid
                    validator: (email) {
                      return email!.contains(RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                          ? null
                          : "Enter a valid email";
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    decoration: textFieldDecsoration.copyWith(
                        hintText: "Enter Your Email : ",
                        suffixIcon: Icon(Icons.email))),
                const SizedBox(
                  height: 33,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      resetPassword();
                    } else {
                      showSnackBar(context, "ERROR");
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(bTNColor),
                    padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                  ),
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Text(
                          "Reset Password",
                          style: TextStyle(fontSize: 19),
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
