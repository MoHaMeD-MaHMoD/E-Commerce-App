// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:e_commerce_app/Shared/myColors.dart';
import 'package:e_commerce_app/model/Products.dart';
import 'package:flutter/material.dart';

import '../Shared/CartAndPriceAppbar.dart';

class Details extends StatefulWidget {
  Product product;
  Details({required this.product});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  // const Details({Key? key}) : super(key: key);
  bool isShowMore = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
           CartAndPriceAppbar()
          ],
          backgroundColor: appbar,
          title: Text("Details screen"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(widget.product.img),
              SizedBox(
                height: 11,
              ),
              Text(
                widget.product.price.toString(),
                style: TextStyle(color: MAIN , fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        "New",
                        style: TextStyle(fontSize: 15),
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 129, 129),
                        borderRadius: BorderRadius.circular(4),
                      )),
                  SizedBox(
                    width: 8,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 26,
                        color: Color.fromARGB(255, 255, 191, 0),
                      ),
                      Icon(
                        Icons.star,
                        size: 26,
                        color: Color.fromARGB(255, 255, 191, 0),
                      ),
                      Icon(
                        Icons.star,
                        size: 26,
                        color: Color.fromARGB(255, 255, 191, 0),
                      ),
                      Icon(
                        Icons.star,
                        size: 26,
                        color: Color.fromARGB(255, 255, 191, 0),
                      ),
                      Icon(
                        Icons.star,
                        size: 26,
                        color: Color.fromARGB(255, 255, 191, 0),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 66,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.edit_location,
                        size: 26,
                        color: Color.fromARGB(168, 3, 65, 27),
                        // color: Color.fromARGB(255, 186, 30, 30),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        widget.product.shop,
                        style: TextStyle(fontSize: 19),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Details : ",
                  style: TextStyle(fontSize: 22),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                " Brand Name	Christian Dior \nItem Form	Liquid \nItem Volume	60 Milliliters \nScent	Wood   \nSpecial Features	Travel Size \nFragrance Concentration	Eau_de_toilette \nMaterial Type Free	Fragrance \nAge Range Description	Adult \nModel Name	Prada Eau De Toilette \nStyle	Modern   \n\nAbout this item : \nBrand: Christian Dior Manufacturer \nNumber: 2724338596599 \nFragrance Type: Eau de Toilette \nSize: 60 ml \nTargeted Group: Men \nFragrance Family: woody",
                style: TextStyle(
                  fontSize: 18,
                ),
                maxLines: isShowMore ? 3 : null,
                overflow: TextOverflow.fade,
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isShowMore = !isShowMore;
                    });
                  },
                  child: Text(
                    isShowMore ? "Show more" : "Show less",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ))
            ],
          ),
        ));
  }
}
