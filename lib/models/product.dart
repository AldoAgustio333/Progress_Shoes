class Product {
  final String name;
  final double price;
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

  factory Product.fromFirestore(Map<String, dynamic> data) {
    return Product(
      name: data['name'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      image: data['image'] ?? 'assets/images/placeholder.png', 
      imageSide: data['imageSide'] ?? 'assets/images/placeholder.png',
      imageBack: data['imageBack'] ?? 'assets/images/placeholder.png',
      imageTop: data['imageTop'] ?? 'assets/images/placeholder.png',
      imageBottom: data['imageBottom'] ?? 'assets/images/placeholder.png',
      desc: data['desc'] ?? '',
    );
  }
}