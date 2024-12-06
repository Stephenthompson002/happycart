class CartItem {
  final String productId;
  final String title;
  final double price;
  final int quantity;
  final String imageUrl;  // Add imageUrl

  CartItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
    required this.imageUrl,  // Initialize imageUrl in the constructor
  });
}
