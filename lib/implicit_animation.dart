import 'package:flutter/material.dart';

class ImplicitAnimation extends StatefulWidget {
  const ImplicitAnimation({super.key});

  @override
  State<ImplicitAnimation> createState() => _ImplicitAnimationState();
}

class _ImplicitAnimationState extends State<ImplicitAnimation> {
  var _isZoomedIn =false;
  double width =200;
  var curve = Curves.bounceInOut;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Center(
          child: Text(
            "Implicit",
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Container
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 370),
                width: width,
                curve: curve,
                child: Image.asset(
                  'assets/download.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _isZoomedIn = !_isZoomedIn;
                width = _isZoomedIn
                    ? MediaQuery.of(context).size.width
                    : 200;
                curve = _isZoomedIn ? Curves.bounceInOut:Curves.bounceOut;
              });
            },
            child: Text(
              _isZoomedIn == false ? "Zoom in": "Zoom out",
              style: const TextStyle(
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
