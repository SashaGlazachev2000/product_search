import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_search/bloc/product_image_bloc.dart/product_image_event.dart';
import 'package:product_search/bloc/product_image_bloc.dart/product_image_state.dart';

class ProductImageBloc extends Bloc<ImageEvent, ProductImageState> {
  ProductImageBloc() : super(InitialProductImageState()) {
    on<ImageGetEvent>(_getImage);
  }

  void _getImage(ImageGetEvent event, Emitter<ProductImageState> emit) {
    if (event.code == null) {
      return;
    }
    final code = event.code;
    final imageState = LoadedProductImageState(
        httpImage:
            "https://ceshops.ru:8443/sem/hs/product_img?code=${code}&index=${event.imagesCount}");
    emit(imageState);
  }
}
