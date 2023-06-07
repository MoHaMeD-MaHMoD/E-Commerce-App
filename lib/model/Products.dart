class Product {
  String shop;
  double price;
  String img;

  Product({required this.price, required this.img, this.shop = "Main pranch"});
}

List<Product> myProducts = [
  Product(
      price: 12.99, img: "assets/img/products/1.jpg", shop: "Silver Oceaan"),
  Product(price: 14.99, img: "assets/img/products/2.jpg", shop: "Naitrous"),
  Product(price: 10.99, img: "assets/img/products/3.jpg", shop: "sweet-home"),
  Product(price: 8.99, img: "assets/img/products/4.jpg", shop: "EL-Shimaa"),
  Product(price: 13.99, img: "assets/img/products/5.jpg", shop: "ELBeaky"),
  Product(price: 18.99, img: "assets/img/products/6.jpg", shop: "Amazon.eg"),
  Product(
      price: 15.99, img: "assets/img/products/7.jpg", shop: "Beauty"),
  Product(price: 16.99, img: "assets/img/products/8.jpg", shop: "ELBeaky"),
];
