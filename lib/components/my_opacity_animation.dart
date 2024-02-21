import 'package:flutter/material.dart';

class MyOpacityAnimation extends StatefulWidget {
  final Widget? child;
  final int? duration;
  final Curve? curve;

  MyOpacityAnimation({
    Key? key, // Added Key? key parameter.
    this.child,
    this.duration = 800,
    this.curve = Curves.fastOutSlowIn,
  }) : super(key: key); // Added super(key: key) to the constructor.

  @override
  State<MyOpacityAnimation> createState() => _MyOpacityAnimationState();
}

class _MyOpacityAnimationState extends State<MyOpacityAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller; // Made the AnimationController non-nullable.
  late Animation<double> animation; // Made the Animation non-nullable.

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration!),
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: widget.curve!),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value,
          child: widget.child,
        );
      },
    );
  }
}
