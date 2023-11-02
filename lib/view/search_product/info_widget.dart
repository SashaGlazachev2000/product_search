import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_search/assets/app_colors.dart';
import 'package:product_search/bloc/product_bloc/product_bloc.dart';
import 'package:product_search/bloc/product_bloc/product_state.dart';
import 'package:product_search/entity/product.dart';

class TextInfoProduct extends StatelessWidget {
  const TextInfoProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        final Product? product =
            state is LoadedProductState ? state.product : null;

        return product != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCellWidget(
                    nameCell: 'Код',
                    infoCell: '${product.code}',
                    colorText: AppColors.appCodeProduct,
                  ),
                  TextCellWidget(
                    nameCell: 'Имя',
                    infoCell: product.name,
                    colorText: AppColors.appTextBackground,
                  ),
                  TextCellWidget(
                    nameCell: 'Цена',
                    infoCell: '${product.price}',
                    colorText: AppColors.appTextBackground,
                  ),
                  TextCellWidget(
                    nameCell: 'Общее кол-во',
                    infoCell: '${product.amount}',
                    colorText: AppColors.appTextBackground,
                  ),
                  TextCellWidget(
                    nameCell: 'Сезон',
                    infoCell: product.isSeasonal ? 'НЕСЕЗОН!' : 'да',
                    colorText: AppColors.appTextBackground,
                  ),
                  ...List.generate(product.stores.length, (index) {
                    final store = product.stores[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        TextCellWidget(
                          nameCell: 'Магазин',
                          infoCell: store.store,
                          colorText: AppColors.appStoreProduct,
                        ),
                        TextCellWidget(
                          nameCell: 'Кол-во',
                          infoCell: '${store.amount}',
                          colorText: AppColors.appTextBackground,
                        ),
                        TextCellWidget(
                          nameCell: 'Свойства',
                          infoCell: store.quality,
                          colorText: AppColors.appTextBackground,
                        ),
                      ],
                    );
                  }),
                ],
              )
            : const SizedBox();
      },
    );
  }
}

class TextCellWidget extends StatelessWidget {
  final String nameCell;
  final String infoCell;
  final Color colorText;

  const TextCellWidget({
    super.key,
    required this.infoCell,
    required this.nameCell,
    required this.colorText,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "$nameCell: $infoCell",
      style: TextStyle(color: colorText, fontSize: 22),
    );
  }
}
