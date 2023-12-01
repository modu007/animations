import 'dart:math';

import 'package:flutter/material.dart';

class CustomPainterAnimation extends StatefulWidget {
  const CustomPainterAnimation({super.key});

  @override
  State<CustomPainterAnimation> createState() => _CustomPainterAnimationState();
}

class Polygon extends CustomPainter{
  final int sides;
  const Polygon({required this.sides, });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =Paint()
        ..color =Colors.blueAccent
        ..strokeWidth=3.0
        ..style=PaintingStyle.stroke
        ..strokeCap =StrokeCap.round;

    final path = Path();
    // x=rsinθ, y=rcosθ
    final Offset offset = Offset(size.width/2,size.height/2);
    final radius = size.width/2;
    final angle = (2 * pi)/sides;
    final angles = List.generate(sides, (index) => index * angle);
    path.moveTo(
      offset.dx + radius * cos(0),
      offset.dy + radius * sin(0),
    );
    for(double angle in angles){
      path.lineTo(
        offset.dx + radius * cos(angle),
        offset.dy + radius * sin(angle),
      );
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is Polygon && oldDelegate.sides != sides;
  }


  
}

class _CustomPainterAnimationState extends State<CustomPainterAnimation>
    with TickerProviderStateMixin {
  late AnimationController sidesController;
  late Animation sidesAnimation;

  @override
  void initState() {
    sidesController = AnimationController(
        vsync: this,
      duration: const Duration(seconds: 3)
    );
    sidesAnimation = IntTween(
      begin: 3,
      end: 10
    ).animate(sidesController);
    super.initState();
  }
  @override
  void didChangeDependencies() {
    sidesController.repeat(reverse: true);
    super.didChangeDependencies();
  }
  @override
  void dispose() {
    sidesController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([
            sidesController
          ]),
          builder: (context,child){
            return CustomPaint(
              painter: Polygon(sides: sidesAnimation.value),
              child: SizedBox(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
              ),
            );
          }
        ),
      ),
    );
  }
}
