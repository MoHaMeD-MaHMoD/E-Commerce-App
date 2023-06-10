// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:e_commerce_app/pages/CheckOut.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/Cart.dart';
import 'myColors.dart';

class CartAndPriceAppbar extends StatelessWidget {
  const CartAndPriceAppbar({super.key});

  @override
  Widget build(BuildContext context) {
     final cartInstance = Provider.of<Cart>(context);
    return  Row(
              children: [
                Stack(
                  children: [
                    Positioned(
                      bottom: 24,
                      child: Container(
                          child: Text(
                            "${cartInstance.selectedProducts.length}",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: second, shape: BoxShape.circle)),
                    ),
                    IconButton(
                      onPressed: () {


                        


                        Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CheckOut()),
                    );



                      },
                      icon: Icon(Icons.add_shopping_cart),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(
                    "\$ ${cartInstance.totalPrice}",
                    style: TextStyle(fontSize: 18 ),
                  ),
                ),
              ],
            )
          ;
  }
}