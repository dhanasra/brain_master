import 'dart:math';

import 'package:flutter/material.dart';

class CloudShape extends CustomPainter{


  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.lightBlueAccent
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    Path path = Path();

    Rect rect = Rect.fromLTWH(10, 50, 50, 50);
    Rect rect2 = Rect.fromLTWH(40,25, 50, 50);
    Rect rect3 = Rect.fromLTWH(40,25, 50, 50);
    Rect rect4 = Rect.fromLTWH(75,50, 50, 50);

    path.arcTo(rect, 2, 2.4, false);
    path.arcTo(rect2, pi, pi/2, false);
    path.arcTo(rect3, 3*pi/2, pi/2, false);
    path.arcTo(rect4, 4, 3.5, false);
    path.lineTo(25,98);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}