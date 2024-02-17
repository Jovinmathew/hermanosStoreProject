import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hermanos/screens/login/screen.dart';
import 'package:hermanos/services/product/service.dart';

import 'services/auth/service.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => ProductService());
  GetIt.I.registerLazySingleton(() => AuthService());
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
        home: Login());
  }
}
