import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  int quantity; // Track quantity of items

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });
}

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {}; // Store items by productId

  Map<String, CartItem> get items {
    return {..._items}; // Return a copy of the cart
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity; // Calculate total amount
    });
    return total;
  }

  void addToCart(String productId, String title, double price, String imageUrl) {
    if (_items.containsKey(productId)) {
      // Product already in cart, increase quantity
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          imageUrl: existingCartItem.imageUrl,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      // Add new product to cart
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          title: title,
          price: price,
          imageUrl: imageUrl,
        ),
      );
    }
    notifyListeners(); // Notify listeners to update UI
  }

  void removeFromCart(String productId) {
    _items.remove(productId); // Remove item from cart
    notifyListeners();
  }

  void clear() {
    _items.clear(); // Clear all items from cart
    notifyListeners();
  }
}
