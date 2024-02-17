import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hermanos/screens/home/screen.dart';
import 'package:hermanos/services/product/service.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => ProductService());
}

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Hermanos Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home());
  }
}
