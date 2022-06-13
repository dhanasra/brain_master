

import 'package:flutter/cupertino.dart';

class SlideAnimation extends StatefulWidget {
  const SlideAnimation({
    Key? key,
    required this.child,
    required this.controller,
    required this.animation,
    this.begin = Offset.zero,
    this.end = const Offset(0.0,0.5),
    this.duration = 2000,
    this.value = 0.5,
    this.transformHits = true,
    this.textDirection = TextDirection.ltr
  }) : super(key: key);

  final Widget child;
  final int duration;
  final Offset begin;
  final Offset end;
  final double value;
  final bool transformHits;
  final TextDirection textDirection;
  final ValueChanged<AnimationController> controller;
  final ValueChanged<Animation<Offset>> animation;

  @override
  _SlideAnimationState createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation> with TickerProviderStateMixin{
  late AnimationController controller;
  late Animation<Offset> slideAnim;

  @override
  void initState() {
    controller = AnimationController(vsync: this,duration: Duration(milliseconds: widget.duration),value: widget.value);
    slideAnim = Tween<Offset>(begin: widget.begin,end: widget.end)
        .animate(controller);

    widget.controller(controller);
    widget.animation(slideAnim);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      transformHitTests: widget.transformHits,
      textDirection: widget.textDirection,
      position: slideAnim,
      child: widget.child,
    );
  }
}
