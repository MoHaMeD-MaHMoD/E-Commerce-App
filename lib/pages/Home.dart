// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, dead_code

import 'package:flutter/material.dart';

import '../Shared/myColors.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Row(
              children: [
                Stack(
                  children: [
                    Positioned(
                      bottom: 24,
                      child: Container(
                          child: Text(
                            "8",
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
            ),
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
                      onTap: () {}),
                  ListTile(
                      title: Text("About"),
                      leading: Icon(Icons.help_center),
                      onTap: () {}),
                  ListTile(
                      title: Text("Logout"),
                      leading: Icon(Icons.exit_to_app),
                      onTap: () {}),
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
