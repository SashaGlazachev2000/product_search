import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_search/entity/product.dart';
import 'package:product_search/services/factory_product.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final factory = ProductFactory();

  ProductBloc()
      : super(
          ProductState(
            product: Product(
                images_count: 0,
                code: 0,
                barcode: 0,
                name: 'name',
                amount: 0,
                price: 0,
                isSeasonal: false,
                quality: '',
                stores: []),
          ),
        ) {
    on<ProductGetProductEvent>(_loadProduct);
  }

  void _loadProduct(
      ProductGetProductEvent event, Emitter<ProductState> emit) async {
    final product = await factory.getProduct(event.code);
    emit(state.copyWith(product: product));
  }
}

class ProductEvent {}

class ProductGetProductEvent extends ProductEvent {
  final int code = 22303;

  // ProductGetProductEvent({required this.code});
}

class ProductState {
  final Product product;
  String _httpImage = '';
  String get httpImage => _httpImage;

  ProductState({
    required this.product,
  }) {
    _httpImage =
        "https://ceshops.ru:8443/sem/hs/product_img?code=${product.code}&index=1";
  }

  ProductState copyWith({
    Product? product,
  }) {
    return ProductState(
      product: product ?? this.product,
    );
  }
}


//реализовал осталось затестить