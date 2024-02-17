import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:hermanos/components/thumbnail/component.dart';
import 'package:hermanos/models/product/model.dart';
import 'package:hermanos/state/cart_notifier.dart';

class ProductList extends StatelessWidget with GetItMixin {
  final List<Product> products;

  ProductList({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartNotifier = get<CartNotifier>();

    return FutureBuilder(
      future: Future.value(products),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (_, index) {
            final product = products[index];
            return ListTile(
              leading: Thumbnail(imageUrl: product.image),
              title: Text(product.title),
              subtitle: CounterWidget(
                product: product,
                cartNotifier: cartNotifier,
              ), // Using the counter widget as subtitle
              trailing: Text(product.price.toString()),
            );
          },
        );
      },
    );
  }
}

class CounterWidget extends StatefulWidget {
  final Product product;
  final CartNotifier cartNotifier;

  CounterWidget({
    required this.product,
    required this.cartNotifier,
  });

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  @override
  Widget build(BuildContext context) {
    int counter = widget.cartNotifier.getQuantity(widget.product);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            setState(() {
              if (counter > 0) {
                widget.cartNotifier.removeFromCart(widget.product);
              }
            });
          },
        ),
        Text(
          counter.toString(),
          style: TextStyle(fontSize: 16),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              widget.cartNotifier.addToCart(widget.product);
            });
          },
        ),
      ],
    );
  }
}
