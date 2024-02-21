import 'package:flutter/material.dart';

class MyTransitionWidget extends StatefulWidget {
  final Widget? child;
  final double? offset;
  final int? duration;
  final Curve? curve;
  final Axis? axis;
  final VoidCallback? onTap; // Fixed typo in the parameter name.

  MyTransitionWidget({
    Key? key, // Added Key? key parameter.
    this.child,
    this.offset = 140.0,
    this.duration = 800,
    this.curve = Curves.elasticOut,
    this.axis = Axis.horizontal,
    this.onTap,
  }) : super(key: key); // Added super(key: key) to the constructor.

  @override
  State<MyTransitionWidget> createState() => _MyTransitionWidgetState();
}

class _MyTransitionWidgetState extends State<MyTransitionWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Added GestureDetector to handle onTap.
      onTap: widget.onTap, // Pass the onTap callback to GestureDetector.
      child: TweenAnimationBuilder<double>(
        duration: Duration(milliseconds: widget.duration!),
        tween: Tween(begin: 1.0, end: 0.0),
        curve: widget.curve!,
        builder: (context, value, child) {
          return Transform.translate(
            offset: widget.axis == Axis.horizontal
                ? Offset(value * widget.offset!, 0.0)
                : Offset(0.0, value * widget.offset!),
            child: widget.child,
          );
        },
      ),
    );
  }
}
