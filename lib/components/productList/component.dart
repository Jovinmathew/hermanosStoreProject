import 'package:flutter/material.dart';
import 'package:hermanos/components/thumbnail/component.dart';
import 'package:hermanos/models/product/model.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;

  const ProductList({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              subtitle: Text(product.category),
              trailing: Text(product.price.toString()),
            );
          },
        );
      },
    );
  }
}
