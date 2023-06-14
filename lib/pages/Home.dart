import 'package:e_commerce_app/Shared/CartAndPriceAppbar.dart';
import 'package:e_commerce_app/Shared/GetUserImg.dart';
import 'package:e_commerce_app/Shared/myColors.dart';
import 'package:e_commerce_app/model/Products.dart';
import 'package:e_commerce_app/pages/CheckOut.dart';
import 'package:e_commerce_app/pages/Detail.dart';
import 'package:e_commerce_app/pages/profilepage.dart';
import 'package:e_commerce_app/provider/Cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartInstance = Provider.of<Cart>(context);
    final currentUser = FirebaseAuth.instance.currentUser!;
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 22),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                    footer: GridTileBar(
                      // backgroundColor: Color.fromARGB(66, 73, 127, 110),
                      trailing: IconButton(
                          color: const Color.fromARGB(255, 62, 94, 70),
                          onPressed: () {
                            cartInstance.addProduct(myProducts[index]);
                          },
                          icon: const Icon(Icons.add)),

                      leading: Text(
                        "\$ ${myProducts[index].price.toString()}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),

                      title: const Text(
                        "",
                      ),
                    ),
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
                  ),
                );
              }),
        ),
        appBar: AppBar(
          actions: const [CartAndPriceAppbar()],
          backgroundColor: appbar,
          title: const Text("Home"),
        ),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/img/background.jpg"),
                            fit: BoxFit.cover),
                      ),
                      currentAccountPicture: const GetUserImg(),
                      accountName: Text(currentUser.displayName!,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255))),
                      accountEmail: Text(currentUser.email!)),
                  ListTile(
                      title: const Text("Profile"),
                      leading: const Icon(Icons.person),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Profile()),
                        );
                      }),
                  ListTile(
                      title: const Text("Home"),
                      leading: const Icon(Icons.home),
                      onTap: () {}),
                  ListTile(
                      title: const Text("My products"),
                      leading: const Icon(Icons.add_shopping_cart),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CheckOut()),
                        );
                      }),
                  ListTile(
                      title: const Text("About"),
                      leading: const Icon(Icons.help_center),
                      onTap: () {}),
                  ListTile(
                      title: const Text("Logout"),
                      leading: const Icon(Icons.exit_to_app),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                      }),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: const Text("Developed by ELBeaky © 2023",
                    style: TextStyle(fontSize: 16)),
              )
            ],
          ),
        ));
  }
}
