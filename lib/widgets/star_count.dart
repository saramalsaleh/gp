import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gp/main.dart';

import 'shadow.dart';

class StarCount extends StatelessWidget {
  final bool isAnimate;

  const StarCount({super.key, this.isAnimate = false});

  static void increment() {
    prefs.setInt('starCount', (prefs.getInt('starCount') ?? 0) + 1);
    notifier.value = Random().nextInt(999);
  }

  static final notifier = ValueNotifier<int>(-1);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        ShadowWidget.image(child: SvgPicture.asset('assets/images/stars.svg')),
        PositionedDirectional(
          start: 54.0,
          child: ValueListenableBuilder(
              valueListenable: notifier,
              builder: (context, value, _) {
                final count = prefs.getInt('starCount') ?? 0;
                final prefCount = max(count - 1, 0);

                if (!isAnimate) {
                  return Text(
                    count.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'ribeye',
                    ),
                  );
                }
                return Animate()
                    .custom(
                      duration: const Duration(seconds: 1),
                      begin: 0,
                      end: 1,
                      builder: (_, value, __) => Text(
                        value >= 1 ? count.toString() : prefCount.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'ribeye',
                        ),
                      ),
                    )
                    .animate();
              }),
        ),
      ],
    );
  }
}