import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_search/assets/app_colors.dart';
import 'package:product_search/bloc/product_bloc/product_bloc.dart';
import 'package:product_search/bloc/product_bloc/product_event.dart';
import 'package:product_search/bloc/product_image_bloc.dart/product_image_bloc.dart';
import 'package:product_search/bloc/product_image_bloc.dart/product_image_event.dart';

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
                hintText: 'Введите код',
                hintStyle: TextStyle(color: AppColors.appGrayHint),
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 22),
              onTap: () {
                controller.text = '';
              },
              onSubmitted: (value) {
                context.read<ProductBloc>().add(ProductGetProductEvent(
                    code: int.tryParse(controller.text)));
                context
                    .read<ProductImageBloc>()
                    .add(ImageGetEvent(code: 22303, imagesCount: 1));
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
            context.read<ProductImageBloc>().add(ImageGetEvent(
                code: int.tryParse(controller.text), imagesCount: 1));
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
