import 'dart:ffi';

import 'package:product_search/entity/store.dart';

class Product {
  Product({
    required this.images_count,
    required this.code,
    required this.barcode,
    required this.name,
    required this.amount,
    required this.price,
    required this.isSeasonal,
    required this.quality,
    required this.stores,
  });

  final String name;
  final int code;
  final int barcode;
  final bool isSeasonal;
  final String quality;
  final int amount;
  final int price;
  final int images_count;
  final List<Store> stores;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] as String,
      code: json['code'] as int,
      barcode: json['barcode'] as int,
      images_count: json['images_count'] as int,
      isSeasonal: json['isSeasonal'] as bool,
      quality: json['quality'] as String,
      amount: json['amount'] as int,
      price: json['price'] as int,
      stores: (json['stores'] as List<dynamic>)
          .map((e) => Store.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
