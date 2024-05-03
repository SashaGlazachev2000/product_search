import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_search/bloc/product_bloc/product_bloc.dart';
import 'package:product_search/bloc/product_bloc/product_state.dart';
import 'package:product_search/bloc/product_image_bloc.dart/product_image_event.dart';
import 'package:product_search/bloc/product_image_bloc.dart/product_image_state.dart';

class ProductImageBloc extends Bloc<ImageEvent, ProductImageState> {
  final ProductBloc productBloc;
  late final StreamSubscription _productBlocSubscription;
  int _currentIndexImage = 1;
  int _countIndexImage = 0;
  int _codeProduct = 0;
  bool _isActiveNextButton = true;
  bool _isActiveBackButton = false;

  ProductImageBloc({required this.productBloc})
      : super(InitialProductImageState()) {
    on<ImageGetEvent>(_getImage);
    on<ImageAddEvent>(_addImageIndex);
    on<ImageRemoveEvent>(_removeImageIndex);
    on<ErrorImageEvent>(_errorImageIndex);
    _productBlocSubscription = productBloc.stream.listen((state) {
      if (state is LoadedProductState) {
        add(
          ImageGetEvent(
              imagesCount: state.product.images_count,
              code: state.product.code),
        );
      }
      if (state is ErrorLoadedProductState) {
        add(
          ErrorImageEvent(),
        );
      }
    });
  }

  @override
  Future<void> close() {
    _productBlocSubscription.cancel();
    return super.close();
  }

  void _getImage(ImageGetEvent event, Emitter<ProductImageState> emit) {
    _currentIndexImage = 1;
    _isActiveBackButton = false;
    _isActiveNextButton = true;

    _codeProduct = event.code;
    _countIndexImage = event.imagesCount;

    if (_countIndexImage == 1 || _countIndexImage == 0) {
      _isActiveBackButton = false;
      _isActiveNextButton = false;
    }

    if (_countIndexImage > 1) {
      _isActiveNextButton = true;
    }

    if (event.code == 0) {
      final errorImageState = LoadedProductImageState(
        isActiveNextButton: false,
        isActiveBackButton: false,
        httpImage: '',
      );
      emit(errorImageState);
    }

    log('_countIndexImage: $_countIndexImage');
    log('_currentIndexImage: $_currentIndexImage');
    log('_isActiveNextButton: $_isActiveNextButton');
    log('_isActiveBackButton: $_isActiveBackButton');
    final imageState = LoadedProductImageState(
        isActiveNextButton: _isActiveNextButton,
        isActiveBackButton: _isActiveBackButton,
        httpImage:
            "https://ceshops.ru:8443/sem/hs/product_img?code=$_codeProduct&index=$_currentIndexImage");
    emit(imageState);
  }

  void _addImageIndex(ImageAddEvent event, Emitter<ProductImageState> emit) {
    if (_countIndexImage > _currentIndexImage) {
      _currentIndexImage++;
      _isActiveBackButton = true;
    }

    if (_currentIndexImage == _countIndexImage) {
      _isActiveNextButton = false;
    }

    final imageState = LoadedProductImageState(
        isActiveNextButton: _isActiveNextButton,
        isActiveBackButton: _isActiveBackButton,
        httpImage:
            "https://ceshops.ru:8443/sem/hs/product_img?code=$_codeProduct&index=$_currentIndexImage");
    emit(imageState);
  }

  void _removeImageIndex(
      ImageRemoveEvent event, Emitter<ProductImageState> emit) {
    if (_countIndexImage >= _currentIndexImage) {
      _currentIndexImage--;
      _isActiveNextButton = true;
    }

    if (_currentIndexImage == 1) {
      _isActiveBackButton = false;
    }

    final imageState = LoadedProductImageState(
        isActiveNextButton: _isActiveNextButton,
        isActiveBackButton: _isActiveBackButton,
        httpImage:
            "https://ceshops.ru:8443/sem/hs/product_img?code=$_codeProduct&index=$_currentIndexImage");
    emit(imageState);
  }

  void _errorImageIndex(
      ErrorImageEvent event, Emitter<ProductImageState> emit) {
    final imageState = LoadedProductImageState(
      isActiveNextButton: false,
      isActiveBackButton: false,
      httpImage: '',
    );

    emit(imageState);
  }
}
