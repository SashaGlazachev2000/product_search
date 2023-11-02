import 'package:flutter/material.dart';
import 'package:product_search/view/search_product.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: const SearchProductWidget());
  }
}
