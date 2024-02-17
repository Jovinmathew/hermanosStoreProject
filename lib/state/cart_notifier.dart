import 'package:flutter/material.dart';
import '../models/product/model.dart';

class CartNotifier extends ChangeNotifier {
  final List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product) {
    final existingProductIndex =
        _cartItems.indexWhere((p) => p.id == product.id);
    if (existingProductIndex != -1) {
      _cartItems[existingProductIndex].quantity += 1;
    } else {
      _cartItems.add(Product(
        id: product.id,
        title: product.title,
        price: product.price,
        image: product.image,
        category: product.category,
        description: product.description,
        quantity: 1,
      ));
    }
    notifyListeners();
  }

  int getQuantity(Product product) {
    final existingProductIndex =
        _cartItems.indexWhere((p) => p.id == product.id);
    if (existingProductIndex != -1) {
      return _cartItems[existingProductIndex].quantity;
    }
    return 0;
  }

  void removeFromCart(Product product) {
    final existingProductIndex =
        _cartItems.indexWhere((p) => p.id == product.id);
    if (existingProductIndex != -1) {
      _cartItems[existingProductIndex].quantity -= 1;
      if (_cartItems[existingProductIndex].quantity <= 0) {
        _cartItems.removeAt(existingProductIndex);
      }
    }
    notifyListeners();
  }

  void addToCartList(Product item) {
    _cartItems.add(item);
    notifyListeners();
  }

  double getCartTotal() {
    double total = 0;
    for (var product in _cartItems) {
      total += product.price * product.quantity;
    }
    return total;
  }
}
