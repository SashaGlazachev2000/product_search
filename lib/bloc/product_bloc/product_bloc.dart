import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_search/bloc/product_bloc/product_event.dart';
import 'package:product_search/bloc/product_bloc/product_state.dart';
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
