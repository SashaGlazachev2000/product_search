import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_search/assets/app_colors.dart';
import 'package:product_search/bloc/product_bloc/product_bloc.dart';
import 'package:product_search/bloc/product_bloc/product_state.dart';

class ImageProductWidget extends StatelessWidget {
  const ImageProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 0.9;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      width: width,
      height: width,
      child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        return Image.network(
          state is LoadedProductState ? state.httpImage : "",
          headers: state is LoadedProductState ? state.headers : {},
          errorBuilder: (context, error, stackTrace) {
            return Container(
              padding: const EdgeInsets.all(100),
              alignment: Alignment.center,
              width: double.infinity,
              height: double.infinity,
              color: AppColors.appGray,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Icon(
                  Icons.search,
                  size: width,
                  color: AppColors.appBackground,
                ),
              ),
            );
          },
          repeat: ImageRepeat.repeatX,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        );
      }),
    );
  }
}
