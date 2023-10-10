import 'package:flutter/material.dart';

class SearchProductWidget extends StatelessWidget {
  const SearchProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 0),
          child: Column(
            children: [
              ImageProductWidget(size: width),
              const SearchWidget(),
            ],
          ),
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
      child: const Image(
        image: AssetImage("assetName"),
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: const TextField()),
        ElevatedButton(onPressed: () {}, child: const Icon(Icons.search))
      ],
    );
  }
}
