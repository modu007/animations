import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart'show Vector3;

class CubeAnimation extends StatefulWidget {
  const CubeAnimation({super.key});

  @override
  State<CubeAnimation> createState() => _CubeAnimationState();
}

class _CubeAnimationState extends State<CubeAnimation> with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;
  late Tween<double> _animation;

  @override
  void initState() {
    super.initState();
    _xController =AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20)
    );
    _yController =AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30)
    );
    _zController =AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40)
    );
    _animation =Tween(end: 0,begin: pi*2);
  }
  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }
  double heightAndWidth =100.0;
  @override
  Widget build(BuildContext context) {
    _xController..reset()..forward();
    _yController..reset()..forward();
    _zController..reset()..forward();
    return  Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
              width: double.infinity,
            ),
            AnimatedBuilder(
              animation: Listenable.merge([
                _xController,
                _yController,
                _zController
              ]),
              builder: (context,child){
                return  Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateX(_animation.evaluate(_xController))
                    ..rotateY(_animation.evaluate(_yController))
                    ..rotateZ(_animation.evaluate(_zController)),
                  child: Stack(
                    children: [
                      //back
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..translate(Vector3(0,0, -heightAndWidth)),
                        child: Container(
                          height: heightAndWidth,
                          width: heightAndWidth,
                          color: Colors.purple,
                        ),
                      ),
                      //left
                      Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()..rotateY(pi/2),
                        child: Container(
                          height: heightAndWidth,
                          width: heightAndWidth,
                          color: Colors.orange,
                        ),
                      ),
                      //right
                      Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()..rotateY(-pi/2),
                        child: Container(
                          height: heightAndWidth,
                          width: heightAndWidth,
                          color: Colors.green,
                        ),
                      ),
                      //bottom
                      Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()..rotateX(pi/2),
                        child: Container(
                          height: heightAndWidth,
                          width: heightAndWidth,
                          color: Colors.blue,
                        ),
                      ),
                      //top
                      Transform(
                        alignment: Alignment.topCenter,
                        transform: Matrix4.identity()..rotateX(-pi/2),
                        child: Container(
                          height: heightAndWidth,
                          width: heightAndWidth,
                          color: Colors.brown,
                        ),
                      ),
                      //front
                      Container(
                        height: heightAndWidth,
                        width: heightAndWidth,
                        color: Colors.red,
                      ),
                    ],
                  ),
                );
              }
            )
          ],
        ),
      ),
    );
  }
}
