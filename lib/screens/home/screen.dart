// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hermanos/components/thumbnail/component.dart';
import 'package:hermanos/models/product/model.dart';
import 'package:hermanos/services/product/service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Product> _products;
  late ProductService _productService;

  @override
  void initState() {
    super.initState();
    _productService = GetIt.I<ProductService>();
    _products = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _products.isEmpty
              ? _productService.getAll()
              : Future.value(_products),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return ListView.builder(
              itemCount: _products.length,
              itemBuilder: (_, index) {
                final product = _products[index];
                return ListTile(
                  leading: Thumbnail(imageUrl: product.image),
                  title: Text(product.title),
                  subtitle: Text(product.category),
                  trailing: Text(product.price.toString()),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final categories = await _productService.getCategories();
          _openBottomModal(context, categories);
        },
        child: Icon(Icons.tune),
      ),
    );
  }

  void _openBottomModal(BuildContext context, List<String> categories) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                trailing: TextButton(
                    child: Text('Reset'),
                    onPressed: () async {
                      final updateProducts = await _productService.getAll();
                      setState(() {
                        _products = updateProducts;
                      });
                      Navigator.pop(context);
                    }),
                leading: Icon(Icons.filter_alt),
                title: Text('Filter Categories'),
              ),
              Wrap(
                spacing: 8.0,
                children: categories
                    .map(
                      (category) => ElevatedButton(
                        onPressed: () async {
                          final updatedProducts =
                              await _productService.getByCategory(category);
                          setState(() {
                            _products = updatedProducts;
                          });
                          Navigator.pop(context);
                        },
                        child: Text(category),
                      ),
                    )
                    .toList(),
              ),
              ListTile(
                leading: Icon(Icons.swap_vert),
                title: Text('Sort By'),
              ),
            ],
          ),
        );
      },
    );
  }
}
