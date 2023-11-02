import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_search/entity/product.dart';
import 'package:product_search/services/factory_product.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final factory = ProductFactory();

  ProductBloc() : super(InitialProductState()) {
    on<ProductGetProductEvent>(_loadProduct);
  }

  void _loadProduct(
      ProductGetProductEvent event, Emitter<ProductState> emit) async {
    if (event.code == null) {
      return;
    }
    final code = event.code;
    final product = await factory.getProduct(code!);
    emit(LoadedProductState(product: product));
  }
}

class ProductEvent {}

class ProductGetProductEvent extends ProductEvent {
  final int? code;

  ProductGetProductEvent({required this.code});
}

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
