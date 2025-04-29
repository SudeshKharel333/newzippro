import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '/screen/product/product_view.dart';
import '/widgets/product.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.query});
  final String query;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

String? _selectedSortOption = 'Price: Low to High'; // Default sorting option
List<String> _sortOptions = [
  'Price: Low to High',
  'Price: High to Low',
  'Rating: High to Low',
  'Rating: Low to High'
];
void _sortProducts(String sortOption) {
  // Pass the selected sort option to the backend or the product list logic
  debugPrint('Sorting by: $sortOption');
  // Call the method to sort products based on the selected option
  // For example, you can call an API to fetch sorted products
  fetchSortedProducts(sortOption);
}

// This method would call the backend or sort your list of products based on the selected option
void fetchSortedProducts(String sortOption) {
  // Your API call or local sorting logic will go here.
  // For example:
  // if (sortOption == 'Price: Low to High') { sortByPrice('asc'); }
  // else if (sortOption == 'Rating: High to Low') { sortByRating('desc'); }
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  final Dio _dio = Dio();
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
      debugPrint('===> Searching api for $query');
      try {
        // Update the URL with query parameter for search
        final response = await _dio.get(
          'http://192.168.1.70:3500/api/products/search',
          queryParameters: {'query': query}, // Pass the search query
        );
        if (response.statusCode == 200) {
          setState(() {
            _products = List<Product>.from(
              response.data.map((item) => Product.fromJson(item)),
            );
            _filteredProducts = _products; // Initially display all products
          });
        } else {
          debugPrint('Failed to load products: ${response.statusCode}');
        }
      } catch (e) {
        debugPrint('Error fetching products: $e');
      }
    }
  }

  void _onSearchBoxTextChange(String searchText) {
    searchProducts(searchText);
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
                                            'http://192.168.1.75:4000/images/${product.image}',
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
