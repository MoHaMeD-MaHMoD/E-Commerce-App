import 'dart:ffi';

import 'package:e_commerce_app/model/Products.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  int totalPrice = 0;
  List selectedProducts = [];

  addProduct(Product product) {
    selectedProducts.add(product);
    totalPrice = totalPrice + product.price.round();
  
    notifyListeners();
  }
}

/*
 Consumer<ClassName>(
  builder: ((context, classInstancee, child) {
  return Text("${classInstancee.myname}");
})),

*/

//    final cartInstance = Provider.of<Cart>(context);
