// ignore_for_file: prefer_const_constructors

import 'package:e_commerce_app/pages/CheckOut.dart';
import 'package:e_commerce_app/pages/Detail.dart';
import 'package:e_commerce_app/provider/Cart.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_app/pages/Home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
    create: (context) {return Cart();},
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
