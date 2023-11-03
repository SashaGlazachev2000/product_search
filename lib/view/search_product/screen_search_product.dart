import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_search/assets/app_colors.dart';
import 'package:product_search/bloc/product_bloc/product_bloc.dart';
import 'package:product_search/bloc/product_image_bloc.dart/product_image_bloc.dart';
import 'package:product_search/view/search_product/image_widget.dart';
import 'package:product_search/view/search_product/info_widget.dart';
import 'package:product_search/view/search_product/search_widget.dart';

class SearchProductWidget extends StatelessWidget {
  SearchProductWidget({super.key});
  final productBloc = ProductBloc();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => productBloc,
        ),
        BlocProvider(
          create: (context) => ProductImageBloc(productBloc: productBloc),
        ),
      ],
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
        physics: const BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ImageProductWidget(),
            const SizedBox(height: 20),
            SearchWidget(),
            const SizedBox(height: 20),
            const TextInfoProduct(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
