import 'package:product_search/entity/product.dart';

class ProductState {}

class InitialProductState extends ProductState {}

class LoadedProductState extends ProductState {
  final Product product;
  String _httpImage = '';
  String get httpImage => _httpImage;
  Map<String, String> headers = {
    "index": "1",
    "Authorization":
        "Basic 0JDQtNC80LjQvdC40YHRgtGA0LDRgtC+0YA6UHNtbWs5MDEyNA=="
  };

  LoadedProductState({required this.product}) {
    _httpImage =
        "https://ceshops.ru:8443/sem/hs/product_img?code=${product.code}&index=1";
  }
}
