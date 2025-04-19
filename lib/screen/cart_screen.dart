import 'package:flutter/material.dart';
import '/widgets/cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Cart item model
  List<CartItem> cartItems = [
    CartItem(
        id: 1,
        title: "Product 1",
        price: 100,
        quantity: 1,
        imageUrl: "https://via.placeholder.com/150"),
    CartItem(
        id: 2,
        title: "Product 2",
        price: 200,
        quantity: 1,
        imageUrl: "https://via.placeholder.com/150"),
    CartItem(
        id: 3,
        title: "Product 3",
        price: 150,
        quantity: 1,
        imageUrl: "https://via.placeholder.com/150"),
  ];

  // Calculate the total price
  double get totalPrice {
    return cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  // Update quantity
  void updateQuantity(int id, int change) {
    setState(() {
      final item = cartItems.firstWhere((item) => item.id == id);
      item.quantity += change;
      if (item.quantity < 1) {
        item.quantity = 1;
      }
    });
  }

  // Remove item from cart
  void removeItem(int id) {
    setState(() {
      cartItems.removeWhere((item) => item.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(fontSize: 20),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.all(10),
                        elevation: 4,
                        child: ListTile(
                          leading: Image.network(
                            item.imageUrl,
                            fit: BoxFit.cover,
                            width: 70,
                            height: 70,
                          ),
                          title: Text(item.title),
                          subtitle: Text("\$${item.price.toStringAsFixed(2)}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () => updateQuantity(item.id, -1),
                                icon: const Icon(Icons.remove),
                              ),
                              Text(item.quantity.toString()),
                              IconButton(
                                onPressed: () => updateQuantity(item.id, 1),
                                icon: const Icon(Icons.add),
                              ),
                              IconButton(
                                onPressed: () => removeItem(item.id),
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Bottom section for total and checkout
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, -3),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "\$${totalPrice.toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(15),
                              backgroundColor: Colors.blue),
                          onPressed: () {
                            // Handle checkout logic here
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Proceeding to Checkout...'),
                              ),
                            );
                          },
                          child: const Text(
                            'Proceed to Checkout',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
