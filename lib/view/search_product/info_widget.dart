import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_search/assets/app_colors.dart';
import 'package:product_search/bloc/product_bloc/product_bloc.dart';
import 'package:product_search/bloc/product_bloc/product_state.dart';
import 'package:product_search/entity/product.dart';
import 'package:product_search/widgets/cell_info_widget.dart';

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
                    colorName: AppColors.appCodeProduct,
                    colorInfo: AppColors.appCodeProduct,
                  ),
                  TextCellWidget(
                    nameCell: 'Имя',
                    infoCell: product.name,
                    colorName: AppColors.appTextBackground,
                  ),
                  TextCellWidget(
                    nameCell: 'Цена',
                    infoCell: '${product.price}',
                    colorName: AppColors.appTextBackground,
                  ),
                  TextCellWidget(
                    nameCell: 'Общее кол-во',
                    infoCell: '${product.amount}',
                    colorName: AppColors.appTextBackground,
                  ),
                  TextCellWidget(
                    nameCell: 'Сезон',
                    infoCell: product.isSeasonal ? 'НЕСЕЗОН!' : 'да',
                    colorName: AppColors.appTextBackground,
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
                          colorName: AppColors.appStoreProduct,
                          colorInfo: AppColors.appStoreProduct,
                        ),
                        TextCellWidget(
                          nameCell: 'Кол-во',
                          infoCell: '${store.amount}',
                          colorName: AppColors.appTextBackground,
                          colorInfo: AppColors.appCellInfo,
                        ),
                        TextCellWidget(
                          nameCell: 'Свойства',
                          infoCell: store.quality,
                          colorName: AppColors.appTextBackground,
                          colorInfo: AppColors.appCellInfo,
                        ),
                      ],
                    );
                  }),
                ],
              )
            : const Align(
                alignment: Alignment.center,
                child: Text(
                  "Начните поиск товара",
                  style: TextStyle(
                      color: AppColors.appGrayHintInfo,
                      fontSize: 15,
                      fontWeight: FontWeight.w200),
                ),
              );
      },
    );
  }
}
