import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_search/assets/app_colors.dart';
import 'package:product_search/bloc/product_bloc/product_bloc.dart';
import 'package:product_search/bloc/product_bloc/product_state.dart';
import 'package:product_search/widgets/next_back_button.dart';

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
      child: Stack(
        children: [
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
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
                            value: loadingProgress.expectedTotalBytes != null
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
                    icon: const Icon(
                      Icons.arrow_back_sharp,
                      color: AppColors.appTextBackground,
                    ),
                    onTap: () {},
                  ),
                  CircleNextButton(
                    icon: const Icon(
                      Icons.arrow_forward_sharp,
                      color: AppColors.appTextBackground,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
