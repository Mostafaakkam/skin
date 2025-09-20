import 'package:flutter/material.dart';
import 'package:skin/core/constant/color.dart';

class BackgroundWidget extends StatelessWidget {
  final bool isSignUp;
  const BackgroundWidget({super.key, this.isSignUp = false});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CustomPaint(
        painter: BackgroundPainter(isSignUp: isSignUp),
      ),
    );
  }
}
class BackgroundPainter extends CustomPainter {
  final bool isSignUp;
  BackgroundPainter({required this.isSignUp});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    // Upper curved shape
    paint.color = AppColor.accentColor;
    Path path1 = Path();
    path1.moveTo(0, size.height * 0.2);
    path1.quadraticBezierTo(size.width * 0.25, size.height * 0.35, size.width-50, size.height * 0.2);
    path1.lineTo(size.width, 0);
    path1.lineTo(0, 0);
    path1.close();
    canvas.drawPath(path1, paint);

    // Lower curved shape
    paint.color = AppColor.primaryColor;
    Path path2 = Path();
    path2.moveTo(0, size.height * 0.01);
    path2.quadraticBezierTo(size.width * 0.25, size.height * 0.35, size.width, size.height * 0.2);
    path2.lineTo(size.width, 0);
    path2.lineTo(0, 0);
    path2.close();
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}