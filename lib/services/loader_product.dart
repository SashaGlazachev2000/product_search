import 'dart:convert';
import 'package:product_search/entity/product.dart';
import 'package:product_search/services/network_client.dart';

class LoaderProduct {
  final _networkClient = NetworkClient();

  Future<Product> fetchProduct(int code) async {
    final response = await _networkClient.fetch(
      'https://ceshops.ru:8443/sem/hs/product_search?barcode=22303',
      {
        "code": "$code",
        "Authorization":
            "Basic 0JDQtNC80LjQvdC40YHRgtGA0LDRgtC+0YA6UHNtbWs5MDEyNA==",
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Product.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
