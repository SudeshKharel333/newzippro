import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:newzippro/constants/config.dart';
import '/widgets/cart.dart'; // Assuming CartItem is defined here
import 'package:get_storage/get_storage.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final storage = GetStorage();
  List<CartItem> cartItems = [];
  int? userId;

  @override
  void initState() {
    super.initState();
    userId = storage.read('userId');
    if (userId != null) {
      fetchItems(userId!);
    } else {
      debugPrint('User ID not found in storage');
    }
  }

  Future<void> fetchItems(int userId) async {
    final url = Uri.parse('${AppConfig.baseUrl}/api/cartitems/$userId');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        setState(() {
          cartItems = data.map((item) => CartItem.fromJson(item)).toList();
        });
      } else {
        debugPrint('Failed to load cart items');
      }
    } catch (e) {
      debugPrint("Error fetching cart items: $e");
    }
  }

  double get totalPrice {
    return cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void updateQuantity(int id, int change) {
    setState(() {
      final item = cartItems.firstWhere((item) => item.product_id == id);
      item.quantity += change;
      if (item.quantity < 1) {
        item.quantity = 1;
      }
    });
  }

  void removeItem(int id) {
    setState(() {
      cartItems.removeWhere((item) => item.product_id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalCost = cartItems.fold(0, (sum, item) => sum + item.total);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
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
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          leading: Image.network(item.image,
                              width: 50, height: 50, fit: BoxFit.cover),
                          title: Text(item.product_name),
                          subtitle: Text(
                              'Price: Rs.${item.price} x ${item.quantity}'),
                          trailing: Text(
                              'Total: Rs.${item.total.toStringAsFixed(2)}'),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Grand Total: Rs.${totalCost.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
    );
  }
}
