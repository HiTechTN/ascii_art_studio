import 'package:flutter/material.dart';

enum CharacterSetType {
  standard,
  detailed,
  minimal,
  binary,
  dots,
  blocks,
  circles,
}

extension CharacterSetTypeExtension on CharacterSetType {
  String get displayName {
    switch (this) {
      case CharacterSetType.standard:
        return 'Standard';
      case CharacterSetType.detailed:
        return 'Detailed';
      case CharacterSetType.minimal:
        return 'Minimal';
      case CharacterSetType.binary:
        return 'Binary';
      case CharacterSetType.dots:
        return 'Dots';
      case CharacterSetType.blocks:
        return 'Blocks';
      case CharacterSetType.circles:
        return 'Circles';
    }
  }

  String get chars {
    switch (this) {
      case CharacterSetType.standard:
        return ' .:-=+*#%@';
      case CharacterSetType.detailed:
        return ' .\'`^",:;Il!i><~+_-?][}{1)(|\\/tfjrxnuvczXYUJCLQ0OZmwqpdbkhao*#MW&8%B@\$';
      case CharacterSetType.minimal:
        return ' .:oO@';
      case CharacterSetType.binary:
        return '01';
      case CharacterSetType.dots:
        return ' ⠁⠂⠄⠆⠇⠈⠉⠊⠋⠌⠍⠎⠏⠐⠑⠒⠓⠔⠕⠖⠗⠘⠙⠚⠛⠜⠝⠞⠟⠠⠡⠢⠣⠤⠥⠦⠧⠨⠩⠪⠫⠬⠭⠮⠯⠰⠱⠲⠳⠴⠵⠶⠷⠸⠹⠺⠻⠼⠽⠾⠿';
      case CharacterSetType.blocks:
        return ' ▤▥▦▧▨▩▬▭▮▯▰▱▲△▴▵▶▷▸▹▼▽◀◁◆◇○●★☆☑☐';
      case CharacterSetType.circles:
        return ' ●◐◑◒◓○◔◕◖◗◘◙◚◛◜◝◞◟◠◡◢◣◤◥◦◧◨◩◪◫◬◭◮◯';
    }
  }
}

class ColorPaletteOption {
  final String name;
  final Color color;

  const ColorPaletteOption({
    required this.name,
    required this.color,
  });

  static const List<ColorPaletteOption> allPalettes = [
    ColorPaletteOption(name: 'Neon Green', color: Color(0xFF39FF14)),
    ColorPaletteOption(name: 'Amber', color: Color(0xFFFFBF00)),
    ColorPaletteOption(name: 'Cyan', color: Color(0xFF00FFFF)),
    ColorPaletteOption(name: 'Pink', color: Color(0xFFFF69B4)),
    ColorPaletteOption(name: 'Matrix Green', color: Color(0xFF00FF00)),
    ColorPaletteOption(name: 'White', color: Colors.white),
    ColorPaletteOption(name: 'Purple', color: Color(0xFF9D00FF)),
    ColorPaletteOption(name: 'Orange', color: Color(0xFFFF6600)),
    ColorPaletteOption(name: 'Blue', color: Color(0xFF0066FF)),
    ColorPaletteOption(name: 'Red', color: Color(0xFFFF0000)),
  ];

  static ColorPaletteOption get defaultPalette => allPalettes[0];
}