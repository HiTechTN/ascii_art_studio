import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../services/ascii_converter.dart';
import '../models/color_palette.dart';

class ImageToAsciiScreen extends StatefulWidget {
  const ImageToAsciiScreen({super.key});

  @override
  State<ImageToAsciiScreen> createState() => _ImageToAsciiScreenState();
}

class _ImageToAsciiScreenState extends State<ImageToAsciiScreen> {
  Uint8List? _imageBytes;
  AsciiResult? _asciiResult;
  bool _isLoading = false;
  int _width = 100;
  CharacterSetType _charSet = CharacterSetType.standard;
  ColorPaletteOption _palette = ColorPaletteOption.allPalettes[0];
  bool _invert = false;
  double _brightness = 0;
  double _contrast = 1;
  bool _showAdvanced = false;

  Future<void> _pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        if (file.bytes != null) {
          setState(() {
            _imageBytes = file.bytes;
          });
          _convertToAscii();
        } else if (file.path != null) {
          final bytes = await File(file.path!).readAsBytes();
          setState(() {
            _imageBytes = bytes;
          });
          _convertToAscii();
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
    }
  }

  void _convertToAscii() {
    if (_imageBytes == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final result = AsciiConverter.convertImageToAscii(
        _imageBytes!,
        width: _width,
        charSet: _charSet,
        invert: _invert,
        brightness: _brightness,
        contrast: _contrast,
      );

      setState(() {
        _asciiResult = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error converting: $e')),
        );
      }
    }
  }

  Future<void> _copyToClipboard() async {
    if (_asciiResult == null) return;
    await Clipboard.setData(ClipboardData(text: _asciiResult!.asciiArt));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Copied to clipboard!')),
      );
    }
  }

  Future<void> _saveAsTxt() async {
    if (_asciiResult == null) return;

    try {
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${directory.path}/ascii_art_$timestamp.txt');
      await file.writeAsString(_asciiResult!.asciiArt);

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

  Future<void> _saveAsHtml() async {
    if (_asciiResult == null) return;

    try {
      final html = AsciiConverter.generateHtml(_asciiResult!, _palette.color);
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${directory.path}/ascii_art_$timestamp.html');
      await file.writeAsString(html);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Saved HTML to: ${file.path}')),
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

  void _showExportDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text('Copy to Clipboard'),
              onTap: () {
                Navigator.pop(context);
                _copyToClipboard();
              },
            ),
            ListTile(
              leading: const Icon(Icons.text_snippet),
              title: const Text('Save as TXT'),
              onTap: () {
                Navigator.pop(context);
                _saveAsTxt();
              },
            ),
            ListTile(
              leading: const Icon(Icons.html),
              title: const Text('Save as HTML (Colored)'),
              onTap: () {
                Navigator.pop(context);
                _saveAsHtml();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image to ASCII'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_showAdvanced ? Icons.expand_less : Icons.expand_more),
            onPressed: () {
              setState(() {
                _showAdvanced = !_showAdvanced;
              });
            },
            tooltip: 'Advanced Options',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.upload),
                  label: const Text('Pick Image'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Width: '),
                    Expanded(
                      child: Slider(
                        value: _width.toDouble(),
                        min: 30,
                        max: 250,
                        divisions: 22,
                        label: _width.toString(),
                        onChanged: (value) {
                          setState(() {
                            _width = value.round();
                          });
                          if (_imageBytes != null) _convertToAscii();
                        },
                      ),
                    ),
                    Text('$_width'),
                  ],
                ),
                Row(
                  children: [
                    const Text('Chars: '),
                    Expanded(
                      child: DropdownButton<CharacterSetType>(
                        value: _charSet,
                        isExpanded: true,
                        items: CharacterSetType.values.map((set) {
                          return DropdownMenuItem(
                            value: set,
                            child: Text(set.displayName),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _charSet = value!;
                          });
                          if (_imageBytes != null) _convertToAscii();
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Color: '),
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
                          setState(() {
                            _palette = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Invert'),
                    Switch(
                      value: _invert,
                      onChanged: (value) {
                        setState(() => _invert = value);
                        if (_imageBytes != null) _convertToAscii();
                      },
                    ),
                  ],
                ),
                if (_showAdvanced) ...[
                  const Divider(),
                  Row(
                    children: [
                      const Text('Brightness: '),
                      Expanded(
                        child: Slider(
                          value: _brightness,
                          min: -0.5,
                          max: 0.5,
                          divisions: 10,
                          label: _brightness.toStringAsFixed(1),
                          onChanged: (value) {
                            setState(() => _brightness = value);
                            if (_imageBytes != null) _convertToAscii();
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Contrast: '),
                      Expanded(
                        child: Slider(
                          value: _contrast,
                          min: 0.5,
                          max: 2.0,
                          divisions: 15,
                          label: _contrast.toStringAsFixed(1),
                          onChanged: (value) {
                            setState(() => _contrast = value);
                            if (_imageBytes != null) _convertToAscii();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _asciiResult == null
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image_outlined, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text('Pick an image to convert'),
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
                              _asciiResult!.asciiArt,
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: _width > 150 ? 6 : 8,
                                color: _palette.color,
                                height: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
          ),
          if (_asciiResult != null)
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
                    onPressed: _showExportDialog,
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