class Product {
  final String id;
  final String title;
  final double price;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  factory Product.fromMap(String id, Map<String, dynamic> data) => Product(
    id: id,
    title: data['title'] ?? '',
    price: (data['price'] ?? 0.0).toDouble(),
    image: data['image'] ?? '',
  );
}
