import 'package:flutter/material.dart';
import 'package:product_search/presenter/my_app.dart';

import 'services/factory_product.dart';

void main() async {
  final factory = ProductFactory();
  final product = await factory.getProduct(22303);
  print(product.name);
  print(product.name);
  print(product.name);
  print(product.name);
  print(product.name);
  runApp(const MyApp());
}
