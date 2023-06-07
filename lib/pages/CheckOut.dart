// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Shared/CartAndPriceAppbar.dart';
import '../Shared/myColors.dart';
import '../provider/Cart.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    final cartInstance = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [CartAndPriceAppbar()],
        backgroundColor: appbar,
        title: Text("Check Out"),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: SizedBox(
                height: 550,
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: cartInstance.selectedProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          title: Text(cartInstance.selectedProducts[index].name),
                          subtitle: Text(
                              "${cartInstance.selectedProducts[index].price} - ${cartInstance.selectedProducts[index].shop}"),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(
                                cartInstance.selectedProducts[index].img),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                cartInstance.removeProduct(cartInstance.selectedProducts[index]);
                              },
                              icon: Icon(Icons.remove)),
                        ),
                      );
                    })),
          ),

          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Pay \$${cartInstance.totalPrice}",
              style: TextStyle(fontSize: 19),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(MAIN),
              padding: MaterialStateProperty.all(EdgeInsets.all(12)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
            ),
          ),
        ],
      ),
    );
  }
}
