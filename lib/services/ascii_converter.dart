import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import '../models/color_palette.dart';

class AsciiResult {
  final String asciiArt;
  final List<List<int>> colorIndices;

  AsciiResult({required this.asciiArt, required this.colorIndices});
}

class AsciiConverter {
  static String getCharacterSet(CharacterSetType set) {
    return set.chars;
  }

  static AsciiResult convertImageToAscii(
    Uint8List imageBytes, {
    int width = 100,
    CharacterSetType charSet = CharacterSetType.standard,
    bool invert = false,
    double brightness = 0,
    double contrast = 1,
  }) {
    final image = img.decodeImage(imageBytes);
    if (image == null) {
      throw Exception('Failed to decode image');
    }

    final aspectRatio = image.height / image.width;
    final height = (width * aspectRatio * 0.5).round();

    final resized = img.copyResize(
      image,
      width: width,
      height: height,
      interpolation: img.Interpolation.average,
    );

    final chars = getCharacterSet(charSet);
    final charCount = chars.length;

    final StringBuffer result = StringBuffer();
    final List<List<int>> colorIndices = [];

    for (int y = 0; y < resized.height; y++) {
      final List<int> rowColors = [];
      for (int x = 0; x < resized.width; x++) {
        final pixel = resized.getPixel(x, y);
        final r = pixel.r.toInt();
        final g = pixel.g.toInt();
        final b = pixel.b.toInt();

        var br = (0.299 * r + 0.587 * g + 0.114 * b) / 255;
        br = ((br - 0.5) * contrast + 0.5 + brightness).clamp(0.0, 1.0);

        final effectiveBrightness = invert ? (1 - br) : br;

        final charIndex = ((charCount - 1) * effectiveBrightness).round();
        final char = chars[charIndex.clamp(0, charCount - 1)];
        result.write(char);
        rowColors.add(((charCount - 1) * effectiveBrightness).round().clamp(0, charCount - 1));
      }
      result.writeln();
      colorIndices.add(rowColors);
    }

    return AsciiResult(
      asciiArt: result.toString(),
      colorIndices: colorIndices,
    );
  }

  static String generateHtml(
    AsciiResult result,
    Color color, {
    String backgroundColor = '#000000',
    String fontFamily = 'monospace',
    int fontSize = 10,
  }) {
    final lines = result.asciiArt.split('\n');
    final colorIndices = result.colorIndices;

    final StringBuffer html = StringBuffer();
    html.writeln('<!DOCTYPE html>');
    html.writeln('<html>');
    html.writeln('<head>');
    html.writeln('<meta charset="UTF-8">');
    html.writeln('<title>ASCII Art</title>');
    html.writeln('</head>');
    html.writeln('<body style="background-color: $backgroundColor; margin: 0; padding: 20px; overflow: auto;">');
    html.writeln('<pre style="font-family: $fontFamily; font-size: ${fontSize}px; line-height: 1.1; color: #${color.value.toRadixString(16).padLeft(8, '0').substring(2)};">');

    final colorHex = color.value.toRadixString(16).padLeft(8, '0').substring(2);

    for (int y = 0; y < lines.length; y++) {
      final line = lines[y];
      final colors = colorIndices[y];
      html.write('<span>');
      for (int x = 0; x < line.length; x++) {
        final char = line[x];
        final colorIndex = colors[x];
        final alpha = (colorIndex * 255 / (colorIndices.isNotEmpty && colorIndices[y].isNotEmpty ? colorIndices[y].length : 10)).round();
        final charColor = _blendColor(color, Colors.black, alpha / 255.0);
        final charHex = charColor.value.toRadixString(16).padLeft(8, '0').substring(2);
        html.write('<span style="color: #$charHex;">$char</span>');
      }
      html.write('</span><br>');
    }

    html.writeln('</pre>');
    html.writeln('</body>');
    html.writeln('</html>');

    return html.toString();
  }

  static Color _blendColor(Color color1, Color color2, double ratio) {
    final r = (color1.red * ratio + color2.red * (1 - ratio)).round();
    final g = (color1.green * ratio + color2.green * (1 - ratio)).round();
    final b = (color1.blue * ratio + color2.blue * (1 - ratio)).round();
    return Color.fromARGB(255, r, g, b);
  }

  static Future<Uint8List?> generatePngFromAscii(String asciiArt, {int fontSize = 12}) async {
    final lines = asciiArt.split('\n');
    if (lines.isEmpty) return null;

    final maxWidth = lines.map((l) => l.length).reduce((a, b) => a > b ? a : b);
    final height = lines.length;
    final width = maxWidth;

    final image = img.Image(width: width, height: height);
    img.fill(image, color: img.ColorRgb8(0, 0, 0));

    for (int y = 0; y < lines.length; y++) {
      final line = lines[y];
      for (int x = 0; x < line.length; x++) {
        final char = line[x];
        final brightness = _getCharBrightness(char);
        final color = (brightness * 255).toInt();
        image.setPixel(x, y, img.ColorRgb8(color, color, color));
      }
    }

    return Uint8List.fromList(img.encodePng(image));
  }

  static double _getCharBrightness(String char) {
    const chars = ' .:-=+*#%@';
    final index = chars.indexOf(char);
    if (index == -1) return 0.5;
    return index / (chars.length - 1);
  }
}