import 'package:animations/cube_animation.dart';
import 'package:animations/hero_animation.dart';
import 'package:animations/implicit_animation.dart';
import 'package:flutter/material.dart';

import 'first_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ImplicitAnimation(),
    );
  }
}

