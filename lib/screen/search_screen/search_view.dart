import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:newzippro/constants/config.dart';
import '/screen/product/product_view.dart';
import '/widgets/product.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.query});
  final String query;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

// Sorting options
String? _selectedSortOption = 'Price: Low to High';
List<String> _sortOptions = [
  'Price: Low to High',
  'Price: High to Low',
  'Rating: High to Low',
  'Rating: Low to High'
];

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Dio _dio = Dio();

  List<Product> _products = [];
  List<Product> _filteredProducts = [];

  bool _isLoading = false;
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.query;
    searchProducts(widget.query);
  }

  Future<void> searchProducts(String query) async {
    if (query.isNotEmpty) {
      setState(() {
        _isLoading = true;
        _errorMessage = "";
      });

      try {
        final response = await _dio.get(
          '${AppConfig.baseUrl}/api/products/search',
          queryParameters: {'query': query},
        );

        if (response.statusCode == 200) {
          setState(() {
            _products = List<Product>.from(
              response.data.map((item) => Product.fromJson(item)),
            );
            _filteredProducts = _products;
            _sortProductList();
          });
        } else {
          setState(() {
            _errorMessage = 'Failed to load products: ${response.statusCode}';
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'Error fetching products: $e';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onSearchBoxTextChange(String searchText) {
    searchProducts(searchText);
  }

  void _sortProductList() {
    setState(() {
      if (_selectedSortOption == 'Price: Low to High') {
        _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
      } else if (_selectedSortOption == 'Price: High to Low') {
        _filteredProducts.sort((a, b) => b.price.compareTo(a.price));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Products"),
        backgroundColor: Colors.purple,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _searchController,
                        onChanged: _onSearchBoxTextChange,
                        decoration: InputDecoration(
                          hintText: "Search for products...",
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Sort by:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          DropdownButton<String>(
                            value: _selectedSortOption,
                            items: _sortOptions.map((String option) {
                              return DropdownMenuItem<String>(
                                value: option,
                                child: Text(option),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  _selectedSortOption = newValue;
                                  _sortProductList();
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _filteredProducts.isEmpty
                          ? const Center(
                              child: Text(
                                "No products found!",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            )
                          : GridView.builder(
                              padding: const EdgeInsets.all(8.0),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                              itemCount: _filteredProducts.length,
                              itemBuilder: (context, index) {
                                final product = _filteredProducts[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductPage(
                                          productId: product.id,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.purpleAccent,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            '${AppConfig.baseUrl}/images/${product.image}',
                                            fit: BoxFit.cover,
                                            height: 100,
                                            width: double.infinity,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Center(
                                                child: Text(
                                                  'Image not available',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              );
                                            },
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.name,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                '\$${product.price}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
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
                ),
    );
  }
}
