import 'dart:ui';

import 'package:flutter/material.dart';

class ShadowWidget extends StatelessWidget {
  final Widget child;
  final bool isImage;
  final double borderRadius;

  const ShadowWidget({
    super.key,
    required this.child,
    this.isImage = false,
    this.borderRadius = 24,
  });

  const ShadowWidget.image({
    super.key,
    required this.child,
    this.isImage = true,
    this.borderRadius = 24,
  });

  @override
  Widget build(BuildContext context) {
    if (isImage) {
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Transform.translate(
            offset: const Offset(0, 4),
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                    width: 0,
                  ),
                ),
                child: Opacity(
                  opacity: 0.3,
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                        Colors.black87, BlendMode.srcATop),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
          child,
        ],
      );
    }
    return PhysicalModel(
      borderRadius: BorderRadius.circular(borderRadius),
      color: Colors.transparent,
      elevation: 6,
      shadowColor: Colors.black38,
      child: child,
    );
  }
}