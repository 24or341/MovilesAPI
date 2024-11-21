import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(10));

    paint.color = Colors.white;
    canvas.drawRRect(rRect, paint);

    paint.color = Colors.green;
    canvas.drawCircle(Offset(20, size.height / 2), 10, paint);

    TextPainter textPainterInstance = TextPainter(
      text: TextSpan(
        text: "Universidad Privada de Tacna - FAING",
        style: TextStyle(fontSize: 10, color: Colors.black),
      ),
      maxLines: 2,
      textDirection: TextDirection.ltr,
    );

    textPainterInstance.layout(minWidth: 0, maxWidth: size.width-50);
    double verticalOffset = (size.height - textPainterInstance.size.height) / 2;
    textPainterInstance.paint(canvas, Offset(40, verticalOffset));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
