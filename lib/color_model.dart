import 'package:flutter/material.dart';

class ColorModel {
  const ColorModel({
    this.nameColor,
    this.color,
  });
  final String nameColor;
  final Color color;
}

final colorList = <ColorModel>[
  ColorModel(nameColor: 'Amarelo', color: Colors.yellow),
  ColorModel(nameColor: 'Verde', color: Colors.green),
  ColorModel(nameColor: 'Azul', color: Colors.blue),
  ColorModel(nameColor: 'Violeta', color: Colors.purple),
];
