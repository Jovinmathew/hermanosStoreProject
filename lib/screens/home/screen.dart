import 'package:flutter/material.dart';
import 'package:hermanos/models/product/model.dart';
import 'package:hermanos/services/product/service.dart';

import '../../components/bottomSheet/component.dart';
import '../../components/productList/component.dart';
import '../cart/screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Product> _products;
  late ProductService _productService;
  late String currentUrl;
  late String _selectedCategory;

  @override
  void initState() {
    super.initState();
    _productService = ProductService();
    currentUrl = ProductService.productsUrl;
    _selectedCategory = '';
    _products = [];
    _loadProducts();
  }

  void _loadProducts() async {
    try {
      final products = await _productService.getAll();
      setState(() {
        _products = products;
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: ProductSearch());
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Cart()),
              );
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Center(
        child: _products.isEmpty
            ? CircularProgressIndicator()
            : ProductList(products: _products),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final categories = await _productService.getCategories();
          _openBottomModal(context, categories);
        },
        child: Icon(Icons.tune),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  void _openBottomModal(BuildContext context, List<String> categories) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FilterBottomSheet(
          categories: categories,
          selectedCategory: _selectedCategory,
          onSelectCategory: (category) async {
            final updatedProducts =
                await _productService.getByCategory(category);
            setState(() {
              currentUrl = '${ProductService.productsUrl}/category/$category';
              _products = updatedProducts;
              _selectedCategory = category;
            });
            Navigator.pop(context);
          },
          onReset: () async {
            final updateProducts = await _productService.getAll();
            setState(() {
              _products = updateProducts;
              currentUrl = ProductService.productsUrl;
              _selectedCategory = '';
            });
            Navigator.pop(context);
          },
          onSort: (order) async {
            final updatedProducts =
                await _productService.sort(order, currentUrl);
            setState(() {
              _products = updatedProducts;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }
}

class ProductSearch extends SearchDelegate<String> {
  final ProductService _productService = ProductService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: _productService.getAll(),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data!
              .where((product) =>
                  product.title.toLowerCase().contains(query.toLowerCase()))
              .toList();
          return ProductList(products: products);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: _productService.getAll(),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data!
              .where((product) =>
                  product.title.toLowerCase().contains(query.toLowerCase()))
              .toList();
          return ProductList(products: products);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
