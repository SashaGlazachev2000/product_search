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

  final int images_count;
  final int code;
  final int barcode;
  final String name;
  final int amount;
  final double price;
  final bool isSeasonal;
  final String quality;
  final List<Store> stores;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      images_count: json['images_count'],
      code: json['code'],
      barcode: json['barcode'],
      name: json['name'],
      amount: json['amount'],
      price: json['price'],
      isSeasonal: json['isSeasonal'],
      quality: json['quality'],
      stores: json['stores'],
    );
  }
}
