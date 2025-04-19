import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatelessWidget {
  final int productId;

  const ProductPage({required this.productId});

  Future<Map<String, dynamic>> fetchProductData() async {
    // final dio = Dio();
    final url = Uri.parse('http://192.168.100.230:4000/product/$productId');

    // try {
    final response = await http.get(url);
    // Make an HTTP GET request to the serve
    // final response =
    //     await dio.get('http://192.168.100.230:4000/product/$productId');
    debugPrint(response.body);
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Map<String, dynamic>>(
          future: fetchProductData(),
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
        future: fetchProductData(),
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
                          'http://192.168.100.230:4000/images/${product['image']}')
                      : SizedBox.shrink(),
                  SizedBox(height: 16),
                  Text(
                    'Description:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(product['description']),
                  SizedBox(height: 16),

                  // Text(
                  //   'Category: ${product['category']}',
                  //   style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  // ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
