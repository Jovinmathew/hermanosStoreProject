// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hermanos/components/thumbnail/component.dart';
import 'package:hermanos/models/product/model.dart';
import 'package:hermanos/services/product/service.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  ProductService get productService => GetIt.I<ProductService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FutureBuilder(
          future: productService.getAll(),
          builder: (_, AsyncSnapshot<List<Product>> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            final products = snapshot.data!;
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
                });
          }),
    ));
  }
}
