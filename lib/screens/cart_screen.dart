import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart'; // Import the CartProvider

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Your Cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<CartProvider>( // Listen to cart changes
        builder: (context, cart, child) {
          // Debug: Print the number of items in the cart
          print('Cart items: ${cart.items.length}');

          return cart.items.isEmpty
              ? const Center(child: Text('Your cart is empty'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cart.items.length,
                        itemBuilder: (context, index) {
                          final cartItem = cart.items.values.toList()[index]; // Access cart item by index

                          // Debugging print: Log each cart item to verify data
                          print('Item in cart: ${cartItem.title}, Quantity: ${cartItem.quantity}, Price: ${cartItem.price}');

                          return ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(cartItem.imageUrl),  // Display imageUrl
                            ),
                            title: Text(cartItem.title),
                            subtitle: Text('Qty: ${cartItem.quantity}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('\$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'), // Calculate total price per item
                                IconButton(
                                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                                  onPressed: () {
                                    // Remove the item from the cart
                                    Provider.of<CartProvider>(context, listen: false)
                                        .removeFromCart(cartItem.id);
                                    print('Removed ${cartItem.title} from cart');
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    // Total Amount Section
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total: \$${cart.totalAmount.toStringAsFixed(2)}', // Display total amount
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Implement checkout functionality (this can be enhanced later)
                              print("Proceeding to Checkout...");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Proceed to Checkout'),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
