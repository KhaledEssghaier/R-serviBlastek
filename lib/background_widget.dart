import 'package:flutter/material.dart';
import 'dart:ui';

class BackgroundWidget extends StatelessWidget {
  final Widget child;

  const BackgroundWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          color: const Color.fromARGB(255, 255, 255, 255).withOpacity(1), // Dark overlay
          child: child,
        ),
      ),
    );
  }
}
