import 'package:flutter/material.dart';
import 'package:product_search/view/search_product/screen_search_product.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: SearchProductWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}
