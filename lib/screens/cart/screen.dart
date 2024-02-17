import 'package:flutter/material.dart';
import 'package:hermanos/components/productList/component.dart';
import 'package:hermanos/state/cart_notifier.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

class Cart extends StatelessWidget with GetItMixin {
  Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartNotifier = get<CartNotifier>();
    final products = cartNotifier.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ProductList(products: products),
            ),
            Divider(),
            ListTile(
              title: Text(
                'Total:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                '\$${cartNotifier.getCartTotal().toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Proceed to checkout logic
              },
              child: Text('Proceed to Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
