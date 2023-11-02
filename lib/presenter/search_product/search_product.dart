import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_search/assets/app_colors.dart';
import 'package:product_search/presenter/search_product/search_product_model.dart';

import 'search_product_bloc.dart';

class SearchProductWidget extends StatelessWidget {
  SearchProductWidget({super.key});

  final model = SearchProductModel();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(),
      child: const Scaffold(
        backgroundColor: AppColors.appBackground,
        body: SearchProductBodyWidget(),
      ),
    );
  }
}

class SearchProductBodyWidget extends StatelessWidget {
  const SearchProductBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ImageProductWidget(),
            const SizedBox(height: 20),
            SearchWidget(),
            const SizedBox(height: 20),
            const TextInfoProduct()
          ],
        ),
      ),
    );
  }
}

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

class SearchWidget extends StatelessWidget {
  final controller = TextEditingController();

  SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 60,
            child: TextField(
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  borderSide: BorderSide(
                    width: 1.5,
                    color: AppColors.appBlue,
                  ),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(width: 2, color: AppColors.appBlue)),
                isCollapsed: true,
                contentPadding: EdgeInsets.all(20),
                fillColor: AppColors.appTextBackground,
                filled: true,
                constraints:
                    BoxConstraints(maxHeight: 10, minHeight: 10, maxWidth: 10),
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 22),
              onTap: () {
                controller.text = '';
              },
              controller: controller,
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            context.read<ProductBloc>().add(
                ProductGetProductEvent(code: int.tryParse(controller.text)));
          },
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(60, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Icon(Icons.search),
        )
      ],
    );
  }
}

class TextInfoProduct extends StatelessWidget {
  const TextInfoProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      return Column(
        children: [
          Text(
            state is LoadedProductState ? "Имя: ${state.product.name}" : "",
            style: const TextStyle(
                color: AppColors.appTextBackground, fontSize: 22),
          ),
          Text(
            state is LoadedProductState ? "Код: ${state.product.code}" : "",
            style: const TextStyle(
                color: AppColors.appTextBackground, fontSize: 22),
          ),
          Text(
            state is LoadedProductState
                ? "Кол-во: ${state.product.amount}"
                : "",
            style: const TextStyle(
                color: AppColors.appTextBackground, fontSize: 22),
          ),
          Text(
            state is LoadedProductState
                ? "Сезон: ${state.product.isSeasonal ? 'СЕЗОН' : 'НЕСЕЗОН'}"
                : "",
            style: const TextStyle(
                color: AppColors.appTextBackground, fontSize: 22),
          ),
          Text(
            state is LoadedProductState ? "Цена: ${state.product.price}" : "",
            style: const TextStyle(
                color: AppColors.appTextBackground, fontSize: 22),
          ),
        ],
      );
    });
  }
}
