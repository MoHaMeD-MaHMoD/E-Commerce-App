// ignore_for_file: prefer_const_constructors

import 'package:e_commerce_app/pages/CheckOut.dart';
import 'package:e_commerce_app/pages/Detail.dart';
import 'package:e_commerce_app/pages/Register.dart';
import 'package:e_commerce_app/provider/Cart.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_app/pages/Home.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return Cart();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Register(),
      ),
    );
  }
}
