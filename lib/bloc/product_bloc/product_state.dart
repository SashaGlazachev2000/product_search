import 'package:product_search/entity/product.dart';

class ProductState {}

class InitialProductState extends ProductState {}

class LoadedProductState extends ProductState {
  final Product product;

  LoadedProductState({required this.product});
}
