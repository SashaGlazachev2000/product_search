import 'package:flutter/material.dart';
import 'package:product_search/assets/app_colors.dart';

class TextCellWidget extends StatelessWidget {
  final String nameCell;
  final String infoCell;
  final Color colorName;
  final Color colorInfo;

  const TextCellWidget({
    super.key,
    required this.infoCell,
    required this.nameCell,
    this.colorName = AppColors.appTextBackground,
    this.colorInfo = AppColors.appTextBackground,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: '$nameCell: ',
              style: TextStyle(color: colorName, fontSize: 22)),
          TextSpan(
              text: infoCell, style: TextStyle(color: colorInfo, fontSize: 22)),
        ],
      ),
    );
  }
}
