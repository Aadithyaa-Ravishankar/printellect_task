class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });

  factory CartItem.fromMap(String id, Map<String, dynamic> data) => CartItem(
    id: id,
    title: data['title'] ?? '',
    price: (data['price'] ?? 0.0).toDouble(),
    quantity: data['quantity'] ?? 1,
  );
}
