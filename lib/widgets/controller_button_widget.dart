import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ControllerButtonWidget extends StatefulWidget {
  final double screenRate = 17.0;
  final String path;
  final VoidCallback onPressed;
  const ControllerButtonWidget(
      {super.key, required this.path, required this.onPressed});

  @override
  State<ControllerButtonWidget> createState() => ControllerButtonWidgetState();
}

class ControllerButtonWidgetState extends State<ControllerButtonWidget> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 0.0,
      ),
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            isPressed = true;
            widget.onPressed();
          });
        },
        onTapUp: (_) {
          setState(() {
            isPressed = false;
          });
        },
        child: Opacity(
          opacity: isPressed ? 0.5 : 1.0,
          child: SizedBox(
            height: screenSize.height / widget.screenRate,
            width: screenSize.width / widget.screenRate,
            child: Image.asset(widget.path),
          ),
        ),
      ),
    );
  }
}
