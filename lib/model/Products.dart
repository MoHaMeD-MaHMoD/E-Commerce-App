class Product {
  final String shop;
  final double price;
  final String img;
  final String name;

  const Product(
      {required this.name,
      required this.price,
      required this.img,
      this.shop = "Main pranch"});
}

List<Product> myProducts = [
  const Product(
      name: "product 1",
      price: 12.99,
      img: "assets/img/products/1.jpg",
      shop: "Silver Oceaan"),
  const Product(
      name: "product 2",
      price: 14.99,
      img: "assets/img/products/2.jpg",
      shop: "Naitrous"),
  const Product(
      name: "product 3",
      price: 10.99,
      img: "assets/img/products/3.jpg",
      shop: "sweet-home"),
  const Product(
      name: "product 4",
      price: 8.99,
      img: "assets/img/products/4.jpg",
      shop: "EL-Shimaa"),
  const Product(
      name: "product 5",
      price: 13.99,
      img: "assets/img/products/5.jpg",
      shop: "ELBeaky"),
  const Product(
      name: "product 1",
      price: 18.99,
      img: "assets/img/products/6.jpg",
      shop: "Amazon.eg"),
  const Product(
      name: "product 7",
      price: 15.99,
      img: "assets/img/products/7.jpg",
      shop: "Beauty"),
  const Product(
      name: "product 8",
      price: 16.99,
      img: "assets/img/products/8.jpg",
      shop: "ELBeaky"),
];
