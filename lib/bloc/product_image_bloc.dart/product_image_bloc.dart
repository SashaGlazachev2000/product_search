import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_search/bloc/product_image_bloc.dart/product_image_event.dart';
import 'package:product_search/bloc/product_image_bloc.dart/product_image_state.dart';

class ProductImageBloc extends Bloc<ImageEvent, ProductImageState> {
  int _currentIndexImage = 1;
  int _countIndexImage = 0;
  int _codeProduct = 0;
  bool _isActiveNextButton = true;
  bool _isActiveBackButton = false;

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

    if (_countIndexImage == 1) {
      _isActiveBackButton = false;
      _isActiveNextButton = false;
    }

    if (_countIndexImage > 1) {
      _isActiveBackButton = true;
      _isActiveNextButton = true;
    }

    final imageState = LoadedProductImageState(
        isActiveNextButton: _isActiveNextButton,
        isActiveBackButton: _isActiveBackButton,
        httpImage:
            "https://ceshops.ru:8443/sem/hs/product_img?code=$_codeProduct&index=$_currentIndexImage");
    emit(imageState);
  }

  void _addImageIndex(ImageAddEvent event, Emitter<ProductImageState> emit) {
    if (_countIndexImage >= _currentIndexImage) {
      _currentIndexImage++;
    }

    if (_countIndexImage < _currentIndexImage) {
      _isActiveNextButton = false;
      _isActiveBackButton = true;
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
    if (_countIndexImage < _currentIndexImage) {
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
}
