import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/color_palette.dart';

class TextToAsciiScreen extends StatefulWidget {
  const TextToAsciiScreen({super.key});

  @override
  State<TextToAsciiScreen> createState() => _TextToAsciiScreenState();
}

class _TextToAsciiScreenState extends State<TextToAsciiScreen> {
  final TextEditingController _textController = TextEditingController();
  String _asciiArt = '';
  int _selectedFontIndex = 2;
  ColorPaletteOption _palette = ColorPaletteOption.allPalettes[0];

  static const List<String> _fonts = [
    'Block (5 lines)',
    'Banner (3 lines)',
    'Standard (5 lines)',
    'Slant (5 lines)',
    'Lean (5 lines)',
    'Script (3 lines)',
    'Big',
  ];

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _generateAscii() {
    if (_textController.text.isEmpty) return;

    setState(() {
      _asciiArt = _generateText(_textController.text.toUpperCase(), _selectedFontIndex);
    });
  }

  String _generateText(String text, int fontIndex) {
    switch (fontIndex) {
      case 0:
        return _generateBlock(text);
      case 1:
        return _generateBanner(text);
      case 2:
        return _generateStandard(text);
      case 3:
        return _generateSlant(text);
      case 4:
        return _generateLean(text);
      case 5:
        return _generateScript(text);
      case 6:
        return _generateBig(text);
      default:
        return _generateStandard(text);
    }
  }

  String _generateBig(String text) {
    final lines = List.filled(7, '');
    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      if (char == ' ') {
        for (int j = 0; j < 7; j++) {
          lines[j] += '  ';
        }
        continue;
      }
      final bigChar = _bigChars[char] ?? ['  ', '  ', '  ', '  ', '  ', '  ', '  '];
      for (int j = 0; j < 7; j++) {
        lines[j] += bigChar[j] + ' ';
      }
    }
    return lines.join('\n');
  }

  static const Map<String, List<String>> _bigChars = {
    'A': ['     ', '  A  ', ' A A ', 'AAAAA', 'A   A', 'A   A', 'A   A'],
    'B': ['BBBB ', 'B   B', 'BBBB ', 'B   B', 'B   B', 'B   B', 'BBBB '],
    'C': ['CCCCCC', 'C    ', 'C    ', 'C    ', 'C    ', 'C    ', 'CCCCCC'],
    'D': ['DDD  ', 'D   D', 'D   D', 'D   D', 'D   D', 'D   D', 'DDD  '],
    'E': ['EEEEE', 'E    ', 'EEE  ', 'E    ', 'E    ', 'E    ', 'EEEEE'],
    'F': ['FFFFF', 'F    ', 'FFF  ', 'F    ', 'F    ', 'F    ', 'F    '],
    'G': ['GGGGGG', 'G    ', 'G    ', 'G  GG', 'G   G', 'G   G', 'GGGGG'],
    'H': ['H   H', 'H   H', 'HHHHH', 'H   H', 'H   H', 'H   H', 'H   H'],
    'I': ['IIIII', '  I  ', '  I  ', '  I  ', '  I  ', '  I  ', 'IIIII'],
    'J': ['JJJJJ', '   J ', '   J ', '   J ', ' J  J', ' J  J', ' JJ  '],
    'K': ['K   K', 'K  K ', 'KKK  ', 'K  K ', 'K   K', 'K   K', 'K   K'],
    'L': ['L    ', 'L    ', 'L    ', 'L    ', 'L    ', 'L    ', 'LLLLL'],
    'M': ['M   M', 'MM MM', 'M M M', 'M   M', 'M   M', 'M   M', 'M   M'],
    'N': ['N   N', 'NN  N', 'N N N', 'N  NN', 'N   N', 'N   N', 'N   N'],
    'O': [' OOO ', 'O   O', 'O   O', 'O   O', 'O   O', 'O   O', ' OOO '],
    'P': ['PPPP ', 'P   P', 'PPPP ', 'P    ', 'P    ', 'P    ', 'P    '],
    'Q': [' QQQ ', 'Q   Q', 'Q   Q', 'Q Q Q', 'Q  Q ', 'Q   Q', ' QQ  '],
    'R': ['RRRR ', 'R   R', 'RRRR ', 'R  R ', 'R   R', 'R   R', 'R   R'],
    'S': ['SSSSS', 'S    ', ' SSSS', '    S', '    S', 'SSSSS', 'SSSSS'],
    'T': ['TTTTT', '  T  ', '  T  ', '  T  ', '  T  ', '  T  ', '  T  '],
    'U': ['U   U', 'U   U', 'U   U', 'U   U', 'U   U', 'U   U', ' UUU '],
    'V': ['V   V', 'V   V', 'V   V', ' V V ', ' V V ', '  V  ', '  V  '],
    'W': ['W   W', 'W   W', 'W   W', 'W W W', 'WW WW', 'WW WW', 'W   W'],
    'X': ['X   X', ' X X ', '  X  ', ' X X ', 'X   X', 'X   X', 'X   X'],
    'Y': ['Y   Y', ' Y Y ', '  Y  ', '  Y  ', '  Y  ', '  Y  ', '  Y  '],
    'Z': ['ZZZZZ', '   Z ', '  Z  ', ' Z   ', 'Z    ', 'Z    ', 'ZZZZZ'],
    '0': [' OOO ', 'O   O', 'O  OO', 'O O  ', 'OO  O', 'O   O', ' OOO '],
    '1': ['  1  ', ' 11  ', '  1  ', '  1  ', '  1  ', '  1  ', '11111'],
    '2': ['22222', '    2', ' 2222', '2    ', '2    ', '2    ', '22222'],
    '3': ['33333', '    3', ' 3333', '    3', '    3', '    3', '33333'],
    '4': ['4   4', '4   4', '44444', '    4', '    4', '    4', '    4'],
    '5': ['55555', '5    ', '55555', '    5', '    5', '    5', '55555'],
    '6': ['66666', '6    ', '66666', '6   6', '6   6', '6   6', '66666'],
    '7': ['77777', '    7', '   7 ', '  7  ', '  7  ', '  7  ', '  7  '],
    '8': ['88888', '8   8', '88888', '8   8', '8   8', '8   8', '88888'],
    '9': ['99999', '9   9', '99999', '    9', '    9', '    9', '99999'],
  };

  String _generateBlock(String text) {
    final lines = List.filled(5, '');
    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      if (char == ' ') {
        for (int j = 0; j < 5; j++) lines[j] += '     ';
        continue;
      }
      final blockChar = _blockChars[char] ?? ['     ', '     ', '     ', '     ', '     '];
      for (int j = 0; j < 5; j++) lines[j] += blockChar[j] + ' ';
    }
    return lines.join('\n');
  }

  static const Map<String, List<String>> _blockChars = {
    'A': ['█████', '█   █', '█████', '█   █', '█   █'],
    'B': ['████  ', '█   █', '████  ', '█   █', '████  '],
    'C': ['█████', '█    ', '█    ', '█    ', '█████'],
    'D': ['████  ', '█   █', '█   █', '█   █', '████  '],
    'E': ['█████', '█    ', '████  ', '█    ', '█████'],
    'F': ['█████', '█    ', '████  ', '█    ', '█    '],
    'G': ['█████', '█    ', '█  ██', '█   █', '█████'],
    'H': ['█   █', '█   █', '█████', '█   █', '█   █'],
    'I': ['█████', '  █  ', '  █  ', '  █  ', '█████'],
    'J': ['█████', '   █', '   █', '█   █', '████ '],
    'K': ['█   █', '█  █ ', '███  ', '█  █ ', '█   █'],
    'L': ['█    ', '█    ', '█    ', '█    ', '█████'],
    'M': ['█   █', '██ ██', '█ █ █', '█   █', '█   █'],
    'N': ['█   █', '██  █', '█ █ █', '█  ██', '█   █'],
    'O': ['█████', '█   █', '█   █', '█   █', '█████'],
    'P': ['█████', '█   █', '█████', '█    ', '█    '],
    'Q': ['█████', '█   █', '█ █ █', '█  █ ', '███ '],
    'R': ['█████', '█   █', '█████', '█  █ ', '█   █'],
    'S': ['█████', '█    ', '█████', '    █', '█████'],
    'T': ['█████', '  █  ', '  █  ', '  █  ', '  █  '],
    'U': ['█   █', '█   █', '█   █', '█   █', '█████'],
    'V': ['█   █', '█   █', '█   █', ' █ █ ', ' █ █ '],
    'W': ['█   █', '█   █', '█ █ █', '██ ██', '█   █'],
    'X': ['█   █', ' █ █ ', '  █  ', ' █ █ ', '█   █'],
    'Y': ['█   █', ' █ █ ', '  █  ', '  █  ', '  █  '],
    'Z': ['█████', '   █', '  █ ', ' █  ', '█████'],
    '0': ['█████', '█   █', '█   █', '█   █', '█████'],
    '1': [' ██ ', '  █ ', '  █ ', '  █ ', '█████'],
    '2': ['█████', '    █', '█████', '█    ', '█████'],
    '3': ['█████', '    █', '█████', '    █', '█████'],
    '4': ['█   █', '█   █', '█████', '    █', '    █'],
    '5': ['█████', '█    ', '█████', '    █', '█████'],
    '6': ['█████', '█    ', '█████', '█   █', '█████'],
    '7': ['█████', '    █', '   █ ', '  █  ', '  █  '],
    '8': ['█████', '█   █', '█████', '█   █', '█████'],
    '9': ['█████', '█   █', '█████', '    █', '█████'],
  };

  String _generateBanner(String text) {
    final lines = List.filled(3, '');
    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      if (char == ' ') {
        for (int j = 0; j < 3; j++) lines[j] += '   ';
        continue;
      }
      final bannerChar = _bannerChars[char] ?? ['   ', '   ', '   '];
      for (int j = 0; j < 3; j++) lines[j] += bannerChar[j] + ' ';
    }
    return lines.join('\n');
  }

  static const Map<String, List<String>> _bannerChars = {
    'A': [' ██ ', '█  █', '████', '█  █', '█  █'],
    'B': ['███ ', '█  █', '███ ', '█  █', '███ '],
    'C': ['████', '█   ', '█   ', '█   ', '████'],
    'D': ['███ ', '█  █', '█  █', '█  █', '███ '],
    'E': ['███ ', '█   ', '███ ', '█   ', '███ '],
    'F': ['███ ', '█   ', '███ ', '█   ', '█   '],
    'G': ['████', '█   ', '█ ██', '█  █', '████'],
    'H': ['█  █', '█  █', '███ ', '█  █', '█  █'],
    'I': ['███ ', ' █ ', ' █ ', ' █ ', '███ '],
    'J': ['███ ', ' █ ', ' █ ', '█ █ ', '██ '],
    'K': ['█  █', '█ █ ', '██  ', '█ █ ', '█  █'],
    'L': ['█   ', '█   ', '█   ', '█   ', '███ '],
    'M': ['█ █ ', '███ ', '█ █ ', '█ █ ', '█ █ '],
    'N': ['█  █', '██ █', '█ █ █', '█  ██', '█  █'],
    'O': ['███ ', '█  █', '█  █', '█  █', '███ '],
    'P': ['███ ', '█  █', '███ ', '█   ', '█   '],
    'Q': ['███ ', '█  █', '█ █ █', '█  █ ', '██  '],
    'R': ['███ ', '█  █', '███ ', '█ █ ', '█  █'],
    'S': ['███ ', '█   ', '███ ', '   █', '███ '],
    'T': ['███ ', ' █ ', ' █ ', ' █ ', ' █ '],
    'U': ['█  █', '█  █', '█  █', '█  █', '███ '],
    'V': ['█  █', '█  █', '█  █', ' █ █ ', ' █ █ '],
    'W': ['█ █ ', '█ █ ', '█ █ ', '███ ', '█ █ '],
    'X': ['█  █', ' █ █', ' █ ', ' █ █', '█  █'],
    'Y': ['█  █', ' █ █', ' █ ', ' █ ', ' █ '],
    'Z': ['███ ', '  █ ', ' █ ', ' █  ', '███ '],
  };

  String _generateStandard(String text) {
    final lines = List.filled(5, '');
    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      if (char == ' ') {
        for (int j = 0; j < 5; j++) lines[j] += '   ';
        continue;
      }
      final standardChar = _standardChars[char] ?? ['   ', '   ', '   ', '   ', '   '];
      for (int j = 0; j < 5; j++) lines[j] += standardChar[j] + ' ';
    }
    return lines.join('\n');
  }

  static const Map<String, List<String>> _standardChars = {
    'A': ['     ', '  █  ', ' █ █ ', '█████', '█   █'],
    'B': ['████ ', '█   █', '████ ', '█   █', '████ '],
    'C': ['█████', '█    ', '█    ', '█    ', '█████'],
    'D': ['████ ', '█   █', '█   █', '█   █', '████ '],
    'E': ['█████', '█    ', '███  ', '█    ', '█████'],
    'F': ['█████', '█    ', '███  ', '█    ', '█    '],
    'G': ['█████', '█    ', '█  ██', '█   █', '█████'],
    'H': ['█   █', '█   █', '█████', '█   █', '█   █'],
    'I': ['█████', '  █  ', '  █  ', '  █  ', '█████'],
    'J': ['█████', '   █ ', '   █ ', '█   █', '████ '],
    'K': ['█   █', '█  █ ', '███  ', '█  █ ', '█   █'],
    'L': ['█    ', '█    ', '█    ', '█    ', '█████'],
    'M': ['█   █', '██ ██', '█ █ █', '█   █', '█   █'],
    'N': ['█   █', '██  █', '█ █ █', '█  ██', '█   █'],
    'O': ['█████', '█   █', '█   █', '█   █', '█████'],
    'P': ['█████', '█   █', '█████', '█    ', '█    '],
    'Q': ['█████', '█   █', '█ █ █', '█  █ ', '███  '],
    'R': ['█████', '█   █', '█████', '█  █ ', '█   █'],
    'S': ['█████', '█    ', '█████', '    █', '█████'],
    'T': ['█████', '  █  ', '  █  ', '  █  ', '  █  '],
    'U': ['█   █', '█   █', '█   █', '█   █', '█████'],
    'V': ['█   █', '█   █', '█   █', ' █ █ ', ' █ █ '],
    'W': ['█   █', '█   █', '█ █ █', '██ ██', '█   █'],
    'X': ['█   █', ' █ █ ', '  █  ', ' █ █ ', '█   █'],
    'Y': ['█   █', ' █ █ ', '  █  ', '  █  ', '  █  '],
    'Z': ['█████', '   █', '  █ ', ' █  ', '█████'],
    '0': ['█████', '█   █', '█   █', '█   █', '█████'],
    '1': [' ██ ', '  █ ', '  █ ', '  █ ', '█████'],
    '2': ['█████', '    █', '█████', '█    ', '█████'],
    '3': ['█████', '    █', '█████', '    █', '█████'],
    '4': ['█   █', '█   █', '█████', '    █', '    █'],
    '5': ['█████', '█    ', '█████', '    █', '█████'],
    '6': ['█████', '█    ', '█████', '█   █', '█████'],
    '7': ['█████', '    █', '   █ ', '  █  ', '  █  '],
    '8': ['█████', '█   █', '█████', '█   █', '█████'],
    '9': ['█████', '█   █', '█████', '    █', '█████'],
  };

  String _generateSlant(String text) {
    final lines = List.filled(5, '');
    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      if (char == ' ') {
        for (int j = 0; j < 5; j++) lines[j] += '    ';
        continue;
      }
      final slantChar = _slantChars[char] ?? ['    ', '    ', '    ', '    ', '    '];
      for (int j = 0; j < 5; j++) lines[j] += slantChar[j] + ' ';
    }
    return lines.join('\n');
  }

  static const Map<String, List<String>> _slantChars = {
    'A': ['   / ', '  /  ', ' █   ', ' █   ', '/____'],
    'B': ['____/', '█   █', '████ ', '█   █', '████ '],
    'C': [' /___', '█    ', '█    ', '█    ', '___/ '],
    'D': ['___  ', '█   █', '█   █', '█   █', '___  '],
    'E': ['____ ', '█    ', '███  ', '█    ', '____ '],
    'F': ['____ ', '█    ', '███  ', '█    ', '█    '],
    'G': [' /__ ', '█    ', '█  __', '█   █', '____]'],
    'H': ['█   █', '█   █', '█████', '█   █', '█   █'],
    'I': ['████ ', '  █  ', '  █  ', '  █  ', '████ '],
    'J': ['█████', '   █ ', '   █ ', '█   █', '___  '],
    'K': ['█   █', '█  █ ', '██   ', '█  █ ', '█   █'],
    'L': ['█    ', '█    ', '█    ', '█    ', '____ '],
    'M': ['█   █', '██ ██', '█ █ █', '█   █', '█   █'],
    'N': ['█   █', '██  █', '█ █ █', '█  ██', '█   █'],
    'O': [' /__ ', '█   █', '█   █', '█   █', '__/  '],
    'P': ['████ ', '█   █', '████ ', '█    ', '█    '],
    'Q': [' /__ ', '█   █', '█ █ █', '█  █ ', '__/  '],
    'R': ['████ ', '█   █', '████ ', '█  █ ', '█   █'],
    'S': [' /__ ', '█    ', '  █  ', '   █ ', '__/  '],
    'T': ['█████', '  █  ', '  █  ', '  █  ', '  █  '],
    'U': ['█   █', '█   █', '█   █', '█   █', '__/  '],
    'V': ['█   █', '█   █', '█   █', ' █ █ ', ' █ █ '],
    'W': ['█   █', '█   █', '█ █ █', '██ ██', '█   █'],
    'X': ['█   █', ' █ █ ', '  █  ', ' █ █ ', '█   █'],
    'Y': ['█   █', ' █ █ ', '  █  ', '  █  ', '  █  '],
    'Z': ['█████', '   █ ', '  █  ', ' █   ', '█████'],
  };

  String _generateLean(String text) {
    final lines = List.filled(3, '');
    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      if (char == ' ') {
        for (int j = 0; j < 3; j++) lines[j] += '  ';
        continue;
      }
      final leanChar = _leanChars[char] ?? ['  ', '  ', '  '];
      for (int j = 0; j < 3; j++) lines[j] += leanChar[j] + ' ';
    }
    return lines.join('\n');
  }

  static const Map<String, List<String>> _leanChars = {
    'A': ['╱   ╱', '╱  ╱ ', '╲╱╲╱', '╱   ╱', '╱   ╱'],
    'B': ['╲╱   ', '╱ ╱  ', '╲╱   ', '╱ ╱  ', '╲╱   '],
    'C': ['╲___ ', '╱    ', '╱    ', '╱    ', '╲___ '],
    'D': ['╲╱   ', '╱ ╲  ', '╱ ╲  ', '╱ ╲  ', '╲╱   '],
    'E': ['╲___ ', '╱    ', '╲__ ', '╱    ', '╲___ '],
    'F': ['╲___ ', '╱    ', '╲__ ', '╱    ', '╱    '],
    'G': ['╲___ ', '╱    ', '╱ ╲_', '╱ ╲  ', '╲╱╲ '],
    'H': ['╱ ╲  ', '╱ ╲  ', '╲╱╲╱', '╱ ╲  ', '╱ ╲  '],
    'I': ['╲╱╲╱', ' ╱╲ ', ' ╱╲ ', ' ╱╲ ', '╲╱╲╱'],
    'J': ['╲╱╲╱', '  ╱╲', '  ╱╲', '╱ ╲ ', '╲__ '],
    'K': ['╱ ╲  ', '╱╲  ', '╲╱   ', '╱╲  ', '╱ ╲  '],
    'L': ['╱    ', '╱    ', '╱    ', '╱    ', '╲___ '],
    'M': ['╱╲╱╲ ', '╱ ╲╱ ', '╱   ╱', '╱   ╱', '╱   ╱'],
    'N': ['╱╲   ', '╱ ╲  ', '╱  ╲ ', '╱   ╱', '╱   ╱'],
    'O': ['╲___ ', '╱   ╱', '╱   ╱', '╱   ╱', '╲___ '],
    'P': ['╲___ ', '╱   ╱', '╲___ ', '╱    ', '╱    '],
    'Q': ['╲___ ', '╱   ╱', '╱ ╲ ╱', '╱  ╲ ', '╲╱╲ '],
    'R': ['╲___ ', '╱   ╱', '╲___ ', '╱ ╲  ', '╱ ╲  '],
    'S': ['╲___ ', '╱    ', '╲__ ', '   ╱ ', '___╱ '],
    'T': ['╲╱╲╱', ' ╱╲ ', ' ╱╲ ', ' ╱╲ ', ' ╱  '],
    'U': ['╱   ╱', '╱   ╱', '╱   ╱', '╱   ╱', '╲___ '],
    'V': ['╱   ╱', '╱   ╱', '╱   ╱', ' ╱ ╲ ', ' ╱ ╲ '],
    'W': ['╱   ╱', '╱   ╱', '╱ ╲ ╱', '╲╱╲╱ ', '╱   ╱'],
    'X': ['╱   ╱', ' ╱ ╲ ', ' ╱╲ ', ' ╱ ╲ ', '╱   ╱'],
    'Y': ['╱   ╱', ' ╱ ╲ ', ' ╱╲ ', '  ╱  ', '  ╱  '],
    'Z': ['╲___ ', '  ╱ ', ' ╱  ', '╱   ', '╲___ '],
  };

  String _generateScript(String text) {
    final lines = List.filled(3, '');
    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      if (char == ' ') {
        for (int j = 0; j < 3; j++) lines[j] += '  ';
        continue;
      }
      final scriptChar = _scriptChars[char] ?? ['  ', '  ', '  '];
      for (int j = 0; j < 3; j++) lines[j] += scriptChar[j] + ' ';
    }
    return lines.join('\n');
  }

  static const Map<String, List<String>> _scriptChars = {
    'A': ['  ╱╲  ', ' ╱  ╲ ', '╱    ╲', '╱   ╲ ', '╲___╱ '],
    'B': ['╱╲   ', ' ╱╲  ', ' ╱╲  ', ' ╱╲  ', ' ╲╱  '],
    'C': [' ╲___', '╱    ', '╱    ', '╱    ', ' ╲__ '],
    'D': ['╱╲   ', ' ╱ ╲ ', ' ╱ ╲ ', ' ╱ ╲ ', ' ╲╱  '],
    'E': ['╱╲   ', ' ╱  ', ' ╱__', ' ╱  ', '╱╲   '],
    'F': ['╱╲   ', ' ╱  ', ' ╱__', ' ╱  ', ' ╱   '],
    'G': [' ╲__', '╱   ', '╱ ╲_', '╱  ╲ ', ' ╲╱ '],
    'H': ['╱ ╲ ', '╱ ╲ ', '╱╲╱╲', '╱ ╲ ', '╱ ╲ '],
    'I': ['╱╲', '╱╲', ' ╱ ', ' ╱ ', '╲╱'],
    'J': ['╱╲', '╱╲', ' ╱╲', '╱ ╲', ' ╲ '],
    'K': ['╱ ╲', '╱╲ ', '╲╱ ', '╱╲ ', '╱ ╲'],
    'L': ['╱  ', '╱  ', '╱  ', '╱  ', '╱╲ '],
    'M': ['╱╲╱', '╱ ╲╱', '╱   ╱', '╱   ╱', '╱   ╱'],
    'N': ['╱╲  ', '╱ ╲ ', '╱  ╲', '╱   ╱', '╱   ╱'],
    'O': [' ╲╱ ', '╱ ╲ ', '╱ ╲ ', '╱ ╲ ', ' ╲╱ '],
    'P': ['╱╲  ', '╱ ╲ ', '╱╲  ', '╱   ', '╱   '],
    'Q': [' ╲╱ ', '╱ ╲ ', '╱ ╲ ', '╱ ╲ ', ' ╲╱╲'],
    'R': ['╱╲  ', '╱ ╲ ', '╱╲  ', '╱ ╲ ', '╱ ╲ '],
    'S': ['╱╲  ', '╱   ', ' ╲╱ ', '   ╱', '╲╱  '],
    'T': ['╱╲', ' ╱ ', ' ╱ ', ' ╱ ', ' ╱ '],
    'U': ['╱ ╲', '╱ ╲', '╱ ╲', '╱ ╲', ' ╲╱'],
    'V': ['╱ ╲', '╱ ╲', '╱ ╲', ' ╱╲ ', ' ╱╲ '],
    'W': ['╱ ╲', '╱ ╲', '╱ ╲', '╱╲╱', '╱   ╱'],
    'X': ['╱ ╲', ' ╱╲ ', ' ╱ ', ' ╱╲ ', '╱ ╲'],
    'Y': ['╱ ╲', ' ╱╲ ', ' ╱ ', ' ╱ ', ' ╱ '],
    'Z': ['╱╲', ' ╱ ', ' ╱ ', ' ╱ ', '╲╱'],
  };

  Future<void> _copyToClipboard() async {
    if (_asciiArt.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: _asciiArt));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Copied to clipboard!')),
      );
    }
  }

  Future<void> _saveToFile() async {
    if (_asciiArt.isEmpty) return;

    try {
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${directory.path}/ascii_text_$timestamp.txt');
      await file.writeAsString(_asciiArt);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Saved to: ${file.path}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text to ASCII'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    hintText: 'Enter text to convert',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.text_fields),
                  ),
                  onSubmitted: (_) => _generateAscii(),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Font: '),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButton<int>(
                        value: _selectedFontIndex,
                        isExpanded: true,
                        items: List.generate(_fonts.length, (index) {
                          return DropdownMenuItem(
                            value: index,
                            child: Text(_fonts[index]),
                          );
                        }),
                        onChanged: (value) {
                          setState(() => _selectedFontIndex = value!);
                          if (_textController.text.isNotEmpty) _generateAscii();
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Color: '),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButton<ColorPaletteOption>(
                        value: _palette,
                        isExpanded: true,
                        items: ColorPaletteOption.allPalettes.map((p) {
                          return DropdownMenuItem(
                            value: p,
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: p.color,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(p.name),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() => _palette = value!);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _generateAscii,
                  icon: const Icon(Icons.auto_awesome),
                  label: const Text('Generate'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: _asciiArt.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.text_fields_outlined, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('Enter text and click Generate'),
                      ],
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        child: SelectableText(
                          _asciiArt,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10,
                            color: _palette.color,
                            height: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
          if (_asciiArt.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: _copyToClipboard,
                    icon: const Icon(Icons.copy),
                    tooltip: 'Copy',
                  ),
                  IconButton(
                    onPressed: _saveToFile,
                    icon: const Icon(Icons.save),
                    tooltip: 'Save',
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}