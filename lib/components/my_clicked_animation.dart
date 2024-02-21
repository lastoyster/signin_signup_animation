import 'package:flutter/material.dart';

class MyClickedAnimation extends StatefulWidget {
  bool? is_select;
  String? title;
  int? duration;
  Curve? curve;
  MyClickedAnimation({
    super.key,
    this.is_select,
    this.title,
    this.duration = 600,
    this.curve = Curves.easeInOutBack,
  });

  @override
  State<MyClickedAnimation> createState() => _MyClickedAnimationState();
}

class _MyClickedAnimationState extends State<MyClickedAnimation> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: widget.duration!),
      transitionBuilder: (child, animation) =>
          ScaleTransition(scale: animation, child: child),
      switchInCurve: widget.curve!,
      child: widget.is_select!
          ? Text(
              widget.title!,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15.0),
              key: const ValueKey("bold"),
            )
          : Text(
              widget.title!,
              style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                  fontSize: 14.0),
              key: const ValueKey("normal"),
            ),
    );
  }
}
