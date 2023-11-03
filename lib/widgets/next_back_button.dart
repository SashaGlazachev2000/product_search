import 'package:flutter/material.dart';
import 'package:product_search/assets/app_colors.dart';

class CircleNextButton extends StatelessWidget {
  final Icon icon;
  final GestureTapCallback onTap;
  final Color backgroundColor;
  final Color splashColor;
  final bool isActive;

  const CircleNextButton(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.isActive,
      this.backgroundColor = AppColors.appGrayOpacity,
      this.splashColor = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isActive,
      child: Opacity(
        opacity: isActive ? 1 : 0,
        child: SizedBox(
          width: 38,
          height: 38,
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
        ),
      ),
    );
  }
}
