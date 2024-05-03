import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_search/bloc/product_bloc/product_event.dart';
import 'package:product_search/bloc/product_bloc/product_state.dart';
import 'package:product_search/services/factory_product.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final _factory = ProductFactory();

  ProductBloc() : super(InitialProductState()) {
    on<ProductGetProductEvent>(_loadProduct);
  }

  void _loadProduct(
      ProductGetProductEvent event, Emitter<ProductState> emit) async {
    log('event.code: ${event.code}', name: 'aaa');

    if (event.code == null) {
      return;
    }
    final code = event.code;
    try {
      final product = await _factory.getProduct(code!);
      emit(LoadedProductState(product: product));
    } catch (e) {
      log('((()))');
      emit(ErrorLoadedProductState());
    }
  }
}
