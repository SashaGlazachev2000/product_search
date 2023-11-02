import 'package:flutter/material.dart';
import 'package:product_search/assets/app_colors.dart';

class CircleNextButton extends StatelessWidget {
  final Icon icon;
  final GestureTapCallback onTap;
  final Color backgroundColor;
  final Color splashColor;

  const CircleNextButton(
      {super.key,
      required this.icon,
      required this.onTap,
      this.backgroundColor = AppColors.appGrayOpacity,
      this.splashColor = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30,
      height: 30,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: FittedBox(
                alignment: Alignment.center,
                child: icon,
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onTap,
              splashColor: splashColor,
            ),
          ),
        ],
      ),
    );
  }
}
