import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_01/providers/customers_provider.dart';
import 'package:shopping_01/providers/products_provider.dart';
import 'package:shopping_01/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductsProvider()),
        ChangeNotifierProvider(create: (context) => CustomersProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
