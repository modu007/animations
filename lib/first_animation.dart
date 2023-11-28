import 'dart:math';

import 'package:flutter/material.dart';

class FirstAnimation extends StatefulWidget {
  const FirstAnimation({super.key});

  @override
  State<FirstAnimation> createState() => _FirstAnimationState();
}

class _FirstAnimationState extends State<FirstAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2)
    );
    _animation = Tween(begin: 0.0,end: 2*pi).animate(_controller);
    _controller.repeat();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context,child){
           return Transform(
             alignment: Alignment.center,
             transform: Matrix4.identity()..rotateY(_animation.value),
             child: Container(
               height: 100,
               width: 100,
               decoration: BoxDecoration(
                   color: Colors.blueAccent,
                   borderRadius: BorderRadius.circular(10),
                   boxShadow: [
                     BoxShadow(
                       spreadRadius: 5.0,
                       offset: const Offset(0.0,3.0),
                       blurRadius: 7,
                       color: Colors.black.withOpacity(0.5),
                     ),
                   ]
               ),
             ),
           );
          },
        ),
      ),
    );
  }
}
