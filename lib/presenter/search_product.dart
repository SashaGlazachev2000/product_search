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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageProductWidget(size: width),
              const SizedBox(height: 20),
              const SearchWidget(),
              const SizedBox(height: 20),
              const TextInfoProduct()
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
        const Expanded(
          child: SizedBox(
            height: 60,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                isCollapsed: true,
                contentPadding: EdgeInsets.all(20),
                constraints:
                    BoxConstraints(maxHeight: 10, minHeight: 10, maxWidth: 10),
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {},
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
    return Text("data");
  }
}
