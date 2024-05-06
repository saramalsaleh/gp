import 'package:flutter/material.dart';
import 'package:gp/constans/utils.dart';
import 'package:gp/widgets/shadow.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onPressed,
    this.widget,
    this.title,
    this.fontSize = 22,
    required this.backgroundColor,
    this.width = 280,
    this.height = 50,
    this.selected = false,
    this.icon,
  });

  final void Function()? onPressed;
  final Widget? widget;
  final String? title;
  final double fontSize;
  final Color backgroundColor;
  final double width;
  final double height;
  final bool selected;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return ShadowWidget(
      child: ElevatedButton(
          onPressed: onPressed ?? () {},
          style: ElevatedButton.styleFrom(
            shape: !selected
                ? null
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0),
                    side: const BorderSide(color: Colors.grey, width: 4),
                  ),
            backgroundColor: backgroundColor,
            fixedSize: Size(width, height),
          ),
          child: title != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        title!,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontFamily: 'ribeye',
                          color: Colors.white,
                          shadows: textShadow,
                        ),
                      ),
                    ),
                    if (icon != null) icon!
                  ],
                )
              : widget),
    );
  }
}