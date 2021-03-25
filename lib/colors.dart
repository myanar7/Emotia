import 'package:flutter/material.dart';

class ColorsAll {
  static final LinearGradient darkGradient = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        Color.fromRGBO(212, 178, 135, 1),
        Color.fromRGBO(19, 17, 17, 1.0)
      ]);
  static final LinearGradient gradient = LinearGradient(colors: [
    Color.fromRGBO(212, 178, 135, 1),
    Color.fromRGBO(212, 178, 135, 1),
  ]);
  static final LinearGradient darkColor = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Colors.black,
      Colors.black,
    ],
  );
}
