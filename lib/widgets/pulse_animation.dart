import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget pulse({bool show = true}) => show ? PulseAnimation(child: this) : this;
}

class PulseAnimation extends StatefulWidget {
  final Widget child;

  const PulseAnimation({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  PulseAnimationState createState() => PulseAnimationState();
}

class PulseAnimationState extends State<PulseAnimation>
    with TickerProviderStateMixin {
  late AnimationController motionController;
  late Animation motionAnimation;

  @override
  void initState() {
    motionController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    motionAnimation = Tween(
      begin: 1.0,
      end: 0.8,
    ).animate(
      CurvedAnimation(
        parent: motionController,
        curve: Curves.easeOut,
      ),
    );

    motionController.repeat(reverse: true);

    super.initState();
  }

  @override
  void dispose() {
    motionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: motionAnimation,
      child: widget.child,
      builder: (context, child) {
        return Transform.scale(
          scale: motionAnimation.value,
          child: child,
        );
      },
    );
  }
}
