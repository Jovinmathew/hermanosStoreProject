import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hermanos/constants/api.dart';
import 'package:hermanos/models/product/model.dart';

class ProductService {
  static const String productsUrl = '$baseUrl/products';

  Future<List<Product>> getAll() async {
    final response = await _get(productsUrl);
    return _extractProducts(response);
  }

  Future<Product?> getSingle(int id) async {
    final response = await _get('$productsUrl/$id');
    return _extractProduct(response);
  }

  Future<List<String>> getCategories() async {
    final response = await _get('$productsUrl/categories');
    return _extractCategories(response);
  }

  Future<List<Product>> getByCategory(String category) async {
    final response = await _get('$productsUrl/category/$category');
    return _extractProducts(response);
  }

  Future<List<Product>> sort(String sortBy, String url) async {
    print('$url?sort=$sortBy');
    final response = await _get('$url?sort=$sortBy');
    return _extractProducts(response);
  }

  Future<http.Response> _get(String url) async {
    return await http.get(Uri.parse(url), headers: headers);
  }

  List<Product> _extractProducts(http.Response response) {
    final products = <Product>[];
    if (response.statusCode == 401) {
      final jsonData = json.decode(response.body);
      for (var item in jsonData) {
        products.add(Product.fromJson(item));
      }
    }
    return products;
  }

  Product? _extractProduct(http.Response response) {
    if (response.statusCode == 401) {
      final jsonData = json.decode(response.body);
      return Product.fromJson(jsonData);
    }
    return null;
  }

  List<String> _extractCategories(http.Response response) {
    final categories = <String>[];
    if (response.statusCode == 401) {
      final jsonData = json.decode(response.body);
      for (var item in jsonData) {
        categories.add(item);
      }
    }
    return categories;
  }
}
