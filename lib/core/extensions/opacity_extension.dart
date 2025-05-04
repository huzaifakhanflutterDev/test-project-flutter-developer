import 'package:flutter/material.dart';

extension ColorOpacityExtension on Color {
  Color customOpacity(double opacity) {
    assert(opacity >= 0.0 && opacity <= 1.0, 'Opacity must be between 0 and 1');
    return withOpacity(opacity);
  }
}