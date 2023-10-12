import 'package:flutter/material.dart';
import 'package:product_search/assets/app_colors.dart';
import 'package:product_search/presenter/search_product/search_product_model.dart';

class SearchProductWidget extends StatefulWidget {
  const SearchProductWidget({super.key});

  @override
  State<SearchProductWidget> createState() => _SearchProductWidgetState();
}

class _SearchProductWidgetState extends State<SearchProductWidget> {
  final model = SearchProductModel();

  @override
  Widget build(BuildContext context) {
    return SearchProductWidgetProvider(
      model: model,
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
    final width = MediaQuery.sizeOf(context).width;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageProductWidget(size: width),
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
  final double size;

  const ImageProductWidget({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.network(
        "https://ceshops.ru:8443/sem/hs/product_img?code=1980980&index=1",
        headers: {
          "code": "22328",
          "index": "1",
          "Authorization":
              "Basic 0JDQtNC80LjQvdC40YHRgtGA0LDRgtC+0YA6UHNtbWs5MDEyNA=="
        },
      ),
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
            SearchProductWidgetProvider.read(context)
                ?.pushCode(int.tryParse(controller.text));
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
    return const Text(
      "asdas",
      style: TextStyle(color: AppColors.appTextBackground, fontSize: 22),
    );
  }
}
