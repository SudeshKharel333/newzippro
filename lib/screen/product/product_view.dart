import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:newzippro/constants/config.dart';
import 'package:quantity_input/quantity_input.dart';

import 'package:intl/intl.dart';

class ProductPage extends StatefulWidget {
  final int productId;
  ProductPage({required this.productId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final storage = GetStorage();

  late Future<Map<String, dynamic>> productFuture;
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    productFuture = fetchProductData();
// Fetch data once when the widget is initialized
  }

  Future<Map<String, dynamic>> fetchProductData() async {
    final url = Uri.parse('${AppConfig.baseUrl}/product/${widget.productId}');
    final response = await http.get(url);
    debugPrint(response.body);
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    int? userId;

    try {
      userId = storage.read('userId');
    } catch (e) {
      print('Error reading userId: $e');
    }
    print("ProductView userId is ${userId}");

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Map<String, dynamic>>(
          future: productFuture, // Use the pre-fetched data
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...');
            } else if (snapshot.hasError) {
              return Text('Error');
            } else if (snapshot.hasData) {
              final product = snapshot.data!;
              return Text(product['product_name']);
            } else {
              return Text('No product');
            }
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: productFuture, // Use the pre-fetched data
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            final product = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['product_name'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$${product['price']}',
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  SizedBox(height: 16),
                  product['image'] != null
                      ? Image.network(
                          '${AppConfig.baseUrl}/images/${product['image']}')
                      : SizedBox.shrink(),
                  SizedBox(height: 16),
                  Text(
                    'Description:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(product['description']),
                  SizedBox(height: 16),
                  Text(
                    "quantity",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  QuantityInput(
                    value:
                        quantity < 1 ? 1 : quantity, // Always show at least 1
                    onChanged: (value) {
                      int newValue =
                          int.tryParse(value.replaceAll(',', '')) ?? 0;
                      if (newValue != quantity) {
                        setState(() {
                          quantity = newValue;
                        });
                      }
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (userId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('User not logged in')),
                        );
                        return;
                      }
                      final url = Uri.parse("${AppConfig.baseUrl}/addToCart");
                      print("DEBUG: userId = $userId");

                      final response = await http.post(
                        url,
                        headers: {"Content-Type": "application/json"},
                        body: jsonEncode({
                          "user_id": userId, // replace with logged-in user's ID
                          "product_id": widget.productId,
                          "quantity":
                              quantity, // quantity from your quantity input
                          "price": product["price"],
                          "product_name": product["product_name"],
                          "image": product["image"],
                        }),
                      );

                      print("The user_id is $userId");

                      if (response.statusCode == 200) {
                        final data = jsonDecode(response.body);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(data['message'])),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to add to cart')),
                        );
                      }

                      print("Response code: ${response.statusCode}");
                      print("Response body: ${response.body}");
                    },
                    child: Text("Add to Cart"),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
