class Product {
  String shop;
  double price;
  String img;
  String name;

  Product({required this.name,required this.price, required this.img, this.shop = "Main pranch"});
}

List<Product> myProducts = [
  Product(
      name: "product 1",
      price: 12.99,
      img: "assets/img/products/1.jpg",
      shop: "Silver Oceaan"),
  Product(
      name: "product 2",
      price: 14.99,
      img: "assets/img/products/2.jpg",
      shop: "Naitrous"),
  Product(
      name: "product 3",
      price: 10.99,
      img: "assets/img/products/3.jpg",
      shop: "sweet-home"),
  Product(
      name: "product 4",
      price: 8.99,
      img: "assets/img/products/4.jpg",
      shop: "EL-Shimaa"),
  Product(
      name: "product 5",
      price: 13.99,
      img: "assets/img/products/5.jpg",
      shop: "ELBeaky"),
  Product(
      name: "product 1",
      price: 18.99,
      img: "assets/img/products/6.jpg",
      shop: "Amazon.eg"),
  Product(
      name: "product 7",
      price: 15.99,
      img: "assets/img/products/7.jpg",
      shop: "Beauty"),
  Product(
      name: "product 8",
      price: 16.99,
      img: "assets/img/products/8.jpg",
      shop: "ELBeaky"),
];
