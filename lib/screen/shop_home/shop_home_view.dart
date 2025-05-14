import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:newzippro/constants/config.dart';
import '/screen/cart_screen.dart';
import '/screen/search_screen/search_view.dart';
import '/widgets/category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '/core/enums/validation_type.dart';
import '/screen/auth/profile/profile_view.dart';
import '/screen/product/product_view.dart';
// Import your search screen
import '../../widgets/input_fields.dart';
import "/widgets/product.dart";
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveRecentlyViewedProduct(int id) async {
  print("$id is saved");
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Get previously saved list
  List<String> recent = prefs.getStringList('recentlyViewed') ?? [];

  // Remove ID if it already exists (to avoid duplicate entries)
  recent.remove(id.toString());

  // Add current product ID to the beginning
  recent.insert(0, id.toString());

  // Keep only the first 10 items
  if (recent.length > 10) {
    recent = recent.sublist(0, 10);
  }

  // Save back to SharedPreferences
  await prefs.setStringList('recentlyViewed', recent);
  print(" RECENT $recent is saved");
}

class ShopHomePage extends StatefulWidget {
  const ShopHomePage({super.key});

  @override
  State<ShopHomePage> createState() => _ShopHomePageState();
}

class _ShopHomePageState extends State<ShopHomePage> {
  // A list to store products fetched from the API.
  List<Product> _products = [];
  late Future<List<Product>> _recentProducts;

// A list to store categories fetched from the API.
  List<Category> _categories = [];

// An instance of the Dio package for making HTTP requests (like GET, POST, etc.).
  // final Dio _dio = Dio();

// A controller to manage the text input field for searching products.
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // This method is called when the widget is first created.
    // It initializes data and prepares the UI for display.

    // Fetch the list of products from the server.
    fetchProducts();
    _recentProducts = getRecentlyViewedProducts(); // Fetch products

    // Fetch the list of categories from the server.
    fetchCategories();
  }

  Future<List<Product>> getRecentlyViewedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> ids = prefs.getStringList('recentlyViewed') ?? [];
    if (ids.isEmpty) return [];

    final response = await Dio().post(
      'http://192.168.1.70:3500/recent-products',
      data: {'ids': ids},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      print("api response is $data");

      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

  Future<void> fetchCategories() async {
    // Define the URL to fetch categories from the server.
    final url = Uri.parse('${AppConfig.baseUrl}/api/categories');

    try {
      // Make an HTTP GET request to the server to get categories.
      final response = await http.get(url);

      // Check if the request was successful (status code 200).
      if (response.statusCode == 200) {
        // Decode the JSON response body into a List of dynamic data.
        List<dynamic> data = json.decode(response.body);

        // Update the _categories list with the parsed data.
        // Convert each item in the list to a Category object using fromJson.
        setState(() {
          _categories = data.map((item) => Category.fromJson(item)).toList();
        });
      } else {
        // If the response is not successful, print an error message.
        debugPrint('Failed to load categories');
      }
    } catch (e) {
      // Handle any errors during the HTTP request or JSON parsing.
      debugPrint("Error fetching categories: $e");
    }
  }

  Future<void> fetchProducts() async {
    // Define the URL to fetch products from the server.
    final url = Uri.parse('${AppConfig.baseUrl}/api/products');

    try {
      // Make an HTTP GET request to the server to get the list of products.
      final response = await http.get(url);

      // Check if the server responded successfully (status code 200).
      if (response.statusCode == 200) {
        // Decode the JSON response into a list of dynamic objects.
        List<dynamic> data = json.decode(response.body);

        // Update the _products list with the parsed product data.
        // Convert each item in the data list into a Product object using fromJson.
        setState(() {
          _products = data.map((item) => Product.fromJson(item)).toList();
        });
      } else {
        // If the response status code is not 200, log an error message.
        debugPrint('Failed to load products');
      }
    } catch (e) {
      // Catch and print any errors that occur during the request or parsing.
      debugPrint("Error fetching products: $e");
    }
  }

  void _onSearch() {
    // Get the trimmed search query from the TextEditingController.
    String query = _searchController.text.trim();

    // Check if the search query is not empty.
    if (query.isNotEmpty) {
      // If the query is valid, navigate to the SearchScreen.
      Navigator.push(
        context, // Use the current context for navigation.
        MaterialPageRoute(
          builder: (context) => SearchScreen(
              query: query), // Pass the search query to the SearchScreen.
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                const SizedBox(height: 220),
                Container(
                  height: 175,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xffb74093),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                ),
                Positioned(
                  top: 155,
                  left: 60,
                  right: 60,
                  child: Row(
                    children: [
                      Expanded(
                        child: CostumeFormField.search(
                          controller: _searchController,
                          validationType: ValidationType.common,
                          hintText: 'Search for products...',
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: _onSearch, // Search action
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/Zippro.png',
                          height: 50,
                          width: 50,
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.person, size: 25),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfilePage()),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.shopping_cart, size: 25),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CartScreen()),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Carousel Slider

            FutureBuilder<List<Product>>(
              future: _recentProducts,
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return CircularProgressIndicator(); // loading

                List<Product> products = snapshot.data!;
                if (products.isEmpty)
                  return Text('No recently viewed products.');

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Recently Viewed",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 90,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ProductPage(productId: product.id),
                                ),
                              );
                            },
                            child: Card(
                              child: Column(
                                children: [
                                  Image.network(
                                      '${AppConfig.baseUrl}/images/${product.image}',
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover),
                                  Text(
                                    product.name,
                                    style: TextStyle(
                                      fontSize:
                                          15, // text size in logical pixels
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '\$${product.price}',
                                    style: TextStyle(
                                      fontSize:
                                          10, // text size in logical pixels
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 30),
            SizedBox(
              height: 180,
              child: CarouselSlider(
                items: [
                  _buildCarouselItem('assets/images/momo.png'),
                  _buildCarouselItem(
                      "https://www.allrecipes.com/thmb/ygY1JXP8_IkDSjPPW5VH2dTiMMU=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/50347-indian-tandoori-chicken-DDMFS-4x3-3035-205e98c80b2f4275b5bd010c396d9149.jpg"),
                ],
                options: CarouselOptions(
                  height: 180.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  viewportFraction: 0.8,
                ),
              ),
            ),
            // Categories Section
            _buildCategoriesSection(),
            // Latest Products
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Latest Products",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return _buildProductCard(product);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselItem(String imageUrl) {
    return Container(
      margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Text(
                'Image not available',
                style: TextStyle(color: Colors.red),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.purpleAccent,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Categories",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 100,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((category) {
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.purple,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Center(
                        child: Text(
                          category.categoryName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        saveRecentlyViewedProduct(product.id); // Save this as recently viewed

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(productId: product.id),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.purpleAccent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                '${AppConfig.baseUrl}/images/${product.image}',
                fit: BoxFit.cover,
                height: 100,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Text(
                      'Image not available',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              '\$${product.price}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
