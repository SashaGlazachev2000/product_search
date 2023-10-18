import 'package:product_search/entity/product.dart';
import 'package:product_search/services/loader_product.dart';

class ProductFactory {
  final _loader = LoaderProduct();

  Future<Product> getProduct(int code) async {
    final product = await _loader.fetchProduct(code);
    return product;
  }
}
