import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hermanos/screens/cart/screen.dart';
import 'package:hermanos/services/product/service.dart';
import 'package:hermanos/state/cart_notifier.dart';

import 'services/auth/service.dart';

void setupLocator() {
  // final GetIt locator = GetIt.asNewInstance();
  GetIt.I.registerLazySingleton(() => ProductService());
  GetIt.I.registerLazySingleton(() => AuthService());
  GetIt.I.registerSingleton(CartNotifier());
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
        home: Cart());
  }
}
