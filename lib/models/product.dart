// lib/models/product.dart
class Product {
  final String name;
  final double price; // Harus double
  final String image;
  final String imageSide;
  final String imageBack;
  final String imageTop;
  final String imageBottom;
  final String desc;

  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.imageSide,
    required this.imageBack,
    required this.imageTop,
    required this.imageBottom,
    required this.desc,
  });
}