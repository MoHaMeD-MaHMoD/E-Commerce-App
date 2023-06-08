// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, dead_code

import 'package:e_commerce_app/model/Products.dart';
import 'package:e_commerce_app/pages/CheckOut.dart';
import 'package:e_commerce_app/pages/Detail.dart';
import 'package:e_commerce_app/provider/Cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Shared/CartAndPriceAppbar.dart';
import '../Shared/myColors.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartInstance = Provider.of<Cart>(context);
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 22),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 33),
              itemCount: myProducts.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Details(product: myProducts[index])),
                    );
                  },
                  child: GridTile(
                    child: Stack(children: [
                      Positioned(
                        top: -3,
                        bottom: -9,
                        right: 0,
                        left: 0,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(55),
                            child: Image.asset(myProducts[index].img)),
                      ),
                    ]),
                    footer: GridTileBar(
                      // backgroundColor: Color.fromARGB(66, 73, 127, 110),
                      trailing: IconButton(
                          color: Color.fromARGB(255, 62, 94, 70),
                          onPressed: () {
                            cartInstance.addProduct(myProducts[index]);
                          },
                          icon: Icon(Icons.add)),

                      leading: Text("\$ ${myProducts[index].price.toString()}",style: TextStyle(fontSize : 16 , fontWeight: FontWeight.w500),),

                      title: Text(
                        "",
                      ),
                    ),
                  ),
                );
              }),
        ),
        appBar: AppBar(
          actions: [
          CartAndPriceAppbar()
          ],
          backgroundColor: appbar,
          title: Text("Home"),
        ),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/img/background.jpg"),
                            fit: BoxFit.cover),
                      ),
                      currentAccountPicture: CircleAvatar(
                        radius: 55,
                        backgroundImage: AssetImage("assets/img/me.jpg"),
                      ),
                      accountName: Text("MoHaMeD MaHMod",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255))),
                      accountEmail: Text("ELBeaky@gmail.com")),
                  ListTile(
                      title: Text("Home"),
                      leading: Icon(Icons.home),
                      onTap: () {}),
                  ListTile(
                      title: Text("My products"),
                      leading: Icon(Icons.add_shopping_cart),
                      onTap: () {

                         Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CheckOut()),
                    );
                      }),
                  ListTile(
                      title: Text("About"),
                      leading: Icon(Icons.help_center),
                      onTap: () {}),
                  ListTile(
                      title: Text("Logout"),
                      leading: Icon(Icons.exit_to_app),
                      onTap: ()async {

await FirebaseAuth.instance.signOut();


                      }),
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 12),
                child: Text("Developed by ELBeaky © 2023",
                    style: TextStyle(fontSize: 16)),
              )
            ],
          ),
        ));
  }
}


/*

Row(
              children: [
                 Stack(
                    children: [
                      Positioned(
                        bottom: 24,
                        child: Container(
                            child: Text(
                              "${cartInstancee.selectedProducts.length}",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: second, shape: BoxShape.circle)),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add_shopping_cart),
                      ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(
                    "\$ 13",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            )            


*/