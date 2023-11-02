import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_search/assets/app_colors.dart';
import 'package:product_search/bloc/product_bloc/product_bloc.dart';
import 'package:product_search/bloc/product_bloc/product_state.dart';
import 'package:product_search/bloc/product_image_bloc.dart/product_image_bloc.dart';
import 'package:product_search/bloc/product_image_bloc.dart/product_image_event.dart';
import 'package:product_search/bloc/product_image_bloc.dart/product_image_state.dart';
import 'package:product_search/entity/product.dart';
import 'package:product_search/widgets/next_back_button.dart';

class ImageProductWidget extends StatelessWidget {
  const ImageProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 0.9;

    return BlocBuilder<ProductImageBloc, ProductImageState>(
        builder: (context, imageState) {
      return imageState is LoadedProductImageState
          ? Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              width: width,
              height: width,
              child: Stack(
                children: [
                  Image.network(
                    imageState.httpImage,
                    headers: imageState.headers,
                    width: double.infinity,
                    height: double.infinity,
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
                            Icons.error,
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
                      return ColoredBox(
                        color: AppColors.appTextBackground,
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleNextButton(
                            isActive: imageState.isActiveBackButton,
                            icon: const Icon(
                              Icons.arrow_back_sharp,
                              color: AppColors.appTextBackground,
                            ),
                            onTap: () {
                              context.read<ProductImageBloc>().add(
                                    ImageRemoveEvent(),
                                  );
                            },
                          ),
                          CircleNextButton(
                            isActive: imageState.isActiveNextButton,
                            icon: const Icon(
                              Icons.arrow_forward_sharp,
                              color: AppColors.appTextBackground,
                            ),
                            onTap: () {
                              context.read<ProductImageBloc>().add(
                                    ImageAddEvent(),
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          : Container(
              padding: const EdgeInsets.all(100),
              alignment: Alignment.center,
              width: width,
              height: width,
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
    });
  }
}
