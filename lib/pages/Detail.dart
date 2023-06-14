import 'package:e_commerce_app/Shared/CartAndPriceAppbar.dart';
import 'package:e_commerce_app/Shared/myColors.dart';
import 'package:e_commerce_app/model/Products.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final Product product;
  const Details({super.key, required this.product});

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
          actions: [const CartAndPriceAppbar()],
          backgroundColor: appbar,
          title: const Text("Details screen"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(widget.product.img),
              const SizedBox(
                height: 11,
              ),
              Text(
                widget.product.price.toString(),
                style: const TextStyle(
                    color: mainColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 129, 129),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        "New",
                        style: TextStyle(fontSize: 15),
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  const Row(
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
                  const SizedBox(
                    width: 66,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.edit_location,
                        size: 26,
                        color: Color.fromARGB(168, 3, 65, 27),
                        // color: Color.fromARGB(255, 186, 30, 30),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        widget.product.shop,
                        style: const TextStyle(fontSize: 19),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  "Details : ",
                  style: TextStyle(fontSize: 22),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                " Brand Name	Christian Dior \nItem Form	Liquid \nItem Volume	60 Milliliters \nScent	Wood   \nSpecial Features	Travel Size \nFragrance Concentration	Eau_de_toilette \nMaterial Type Free	Fragrance \nAge Range Description	Adult \nModel Name	Prada Eau De Toilette \nStyle	Modern   \n\nAbout this item : \nBrand: Christian Dior Manufacturer \nNumber: 2724338596599 \nFragrance Type: Eau de Toilette \nSize: 60 ml \nTargeted Group: Men \nFragrance Family: woody",
                style: const TextStyle(
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
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ))
            ],
          ),
        ));
  }
}
