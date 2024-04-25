import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:product_search/assets/app_colors.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 0.9;

    log(image, name: 'aab');
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                // panEnabled: false, // Set it to false
                // boundaryMargin: const EdgeInsets.all(100),
                minScale: 1,
                maxScale: 10,
                child: Image.network(
                  image,
                  headers: const {
                    "Authorization":
                        "Basic 0JDQtNC80LjQvdC40YHRgtGA0LDRgtC+0YA6UHNtbWs5MDEyNA=="
                  },
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
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
