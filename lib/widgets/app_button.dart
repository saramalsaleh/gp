import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    this.widget,
    this.title,
    this.fontSize = 26.0,
    required this.backgroundColor,
    this.width = 260,
    this.height = 50,
  });
  final void Function()? onPressed;
  final Widget? widget;
  final String? title;
  final double fontSize;
  final Color backgroundColor;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(backgroundColor),
          fixedSize: MaterialStatePropertyAll(Size(width, height)),
        ),
        child: title != null
            ? Text(
                title!,
                style: TextStyle(
                    fontSize: fontSize,
                    fontFamily: 'ribeye',
                    color: Colors.white),
              )
            : widget);
  }
}