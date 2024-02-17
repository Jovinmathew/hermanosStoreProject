import 'package:flutter/material.dart';

import '../models/product/model.dart';

class CartNotifier extends ChangeNotifier {
  final List<Product> _cartItems = [
    Product(
        id: 1,
        title: 'Product 1',
        price: 10,
        image: 'https://via.placeholder.com/150',
        category: 'category 1',
        description: 'description one'),
    Product(
        id: 2,
        title: 'Product 2',
        price: 20,
        image: 'https://via.placeholder.com/150',
        category: 'category 2',
        description: 'description two'),
    Product(
        id: 3,
        title: 'Product 3',
        price: 15,
        image: 'https://via.placeholder.com/150',
        category: 'category 3',
        description: 'description three'),
  ];

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void addToCartList(Product item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeFromCartList(Product item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  double getCartTotal() {
    double total = 0;
    for (var product in _cartItems) {
      total += product.price;
    }
    return total;
  }
}
