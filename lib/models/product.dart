class Product {
  final String name;
  final String price;
  final String desc;
  final String image;
  final String imageSide;
  final String imageBack;
  final String imageTop;
  final String imageBottom;

  Product({
    required this.name,
    required this.price,
    required this.desc,
    required this.image,
    required this.imageSide,
    required this.imageBack,
    required this.imageTop,
    required this.imageBottom,
  });

  factory Product.fromFirestore(Map<String, dynamic> data) {
    return Product(
      name: data['name'] ?? '',
      price: data['price'] ?? '',
      desc: data['desc'] ?? '',
      image: data['image'] ?? '',
      imageSide: data['imageSide'] ?? '',
      imageBack: data['imageBack'] ?? '',
      imageTop: data['imageTop'] ?? '',
      imageBottom: data['imageBottom'] ?? '',
    );
  }
}

