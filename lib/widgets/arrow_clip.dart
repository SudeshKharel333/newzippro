import 'package:flutter/material.dart';

/// Clipper to Cut widget at the side

class ArrowClipReversed extends CustomClipper<Path> {

  int cutLength= 20;
  ArrowClipReversed(int i) {
    cutLength = i;
  }

  /// Play with scals to get more clear versions
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    final path = Path();
    path.lineTo(width, 0);
    // path.lineTo(width-cutLength, height / 2);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.lineTo(cutLength.toDouble(), height / 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
