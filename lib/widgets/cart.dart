// Model class for Cart Item
class CartItem {
  final int product_id;
  final String product_name;
  final double price;
  int quantity;
  final String image;

  CartItem({
    required this.product_id,
    required this.product_name,
    required this.price,
    required this.quantity,
    required this.image,
  });

  // Add this fromJson method
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product_id: json['product_id'],
      product_name: json['product_name'],
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'],
      image: json['image'],
    );
  }
  double get total => price * quantity;
}
