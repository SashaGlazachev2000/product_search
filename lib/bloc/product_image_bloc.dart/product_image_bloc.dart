import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_search/bloc/product_image_bloc.dart/product_image_event.dart';
import 'package:product_search/bloc/product_image_bloc.dart/product_image_state.dart';

class ProductImageBloc extends Bloc<ImageEvent, ProductImageState> {
  int _currentIndexImage = 1;
  int _countIndexImage = 0;
  int _codeProduct = 0;

  ProductImageBloc() : super(InitialProductImageState()) {
    on<ImageGetEvent>(_getImage);
    on<ImageAddEvent>(_addImageIndex);
    on<ImageRemoveEvent>(_removeImageIndex);
  }

  void _getImage(ImageGetEvent event, Emitter<ProductImageState> emit) {
    if (event.code == null) {
      return;
    }

    _codeProduct = event.code!;
    _countIndexImage = event.imagesCount;

    final imageState = LoadedProductImageState(
        httpImage:
            "https://ceshops.ru:8443/sem/hs/product_img?code=$_codeProduct&index=$_currentIndexImage");
    emit(imageState);
  }

  void _addImageIndex(ImageAddEvent event, Emitter<ProductImageState> emit) {
    if (_countIndexImage >= _currentIndexImage) {
      _currentIndexImage++;
    }

    final imageState = LoadedProductImageState(
        httpImage:
            "https://ceshops.ru:8443/sem/hs/product_img?code=$_codeProduct&index=$_currentIndexImage");
    emit(imageState);
  }

  void _removeImageIndex(
      ImageRemoveEvent event, Emitter<ProductImageState> emit) {
    if (_countIndexImage < _currentIndexImage) {
      _currentIndexImage--;
    }

    final imageState = LoadedProductImageState(
        httpImage:
            "https://ceshops.ru:8443/sem/hs/product_img?code=$_codeProduct&index=$_currentIndexImage");
    emit(imageState);
  }
}
