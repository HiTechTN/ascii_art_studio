import 'package:flutter/material.dart';
import '../models/color_palette.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ThemeMode _themeMode = ThemeMode.system;
  CharacterSetType _defaultCharSet = CharacterSetType.standard;
  ColorPaletteOption _defaultPalette = ColorPaletteOption.allPalettes[0];
  int _defaultWidth = 100;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const _SectionHeader(title: 'Appearance'),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text('Theme'),
            subtitle: Text(_themeModeLabel),
            onTap: _showThemeDialog,
          ),
          const Divider(),
          const _SectionHeader(title: 'Defaults'),
          ListTile(
            leading: const Icon(Icons.text_fields),
            title: const Text('Default Character Set'),
            subtitle: Text(_defaultCharSet.displayName),
            onTap: _showCharSetDialog,
          ),
          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text('Default Color Palette'),
            subtitle: Text(_defaultPalette.name),
            onTap: _showPaletteDialog,
          ),
          ListTile(
            leading: const Icon(Icons.aspect_ratio),
            title: const Text('Default Width'),
            subtitle: Text('$_defaultWidth characters'),
            onTap: _showWidthDialog,
          ),
          const Divider(),
          const _SectionHeader(title: 'Language'),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            subtitle: Text(_language),
            onTap: _showLanguageDialog,
          ),
          const Divider(),
          const _SectionHeader(title: 'About'),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('ASCII Art Studio'),
            subtitle: const Text('Version 1.0.0'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.code),
            title: const Text('Open Source'),
            subtitle: const Text('Built with Flutter'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  String get _themeModeLabel {
    switch (_themeMode) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }

  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ThemeMode.values.map((mode) {
            return RadioListTile<ThemeMode>(
              title: Text(mode == ThemeMode.system ? 'System' : mode == ThemeMode.light ? 'Light' : 'Dark'),
              value: mode,
              groupValue: _themeMode,
              onChanged: (value) {
                setState(() => _themeMode = value!);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showCharSetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Character Set'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: CharacterSetType.values.map((set) {
              return RadioListTile<CharacterSetType>(
                title: Text(set.displayName),
                value: set,
                groupValue: _defaultCharSet,
                onChanged: (value) {
                  setState(() => _defaultCharSet = value!);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _showPaletteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Color Palette'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: ColorPaletteOption.allPalettes.map((palette) {
              return RadioListTile<ColorPaletteOption>(
                title: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: palette.color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(palette.name),
                  ],
                ),
                value: palette,
                groupValue: _defaultPalette,
                onChanged: (value) {
                  setState(() => _defaultPalette = value!);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _showWidthDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Default Width'),
        content: StatefulBuilder(
          builder: (context, setStateDialog) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('$_defaultWidth characters'),
                Slider(
                  value: _defaultWidth.toDouble(),
                  min: 30,
                  max: 250,
                  divisions: 22,
                  label: _defaultWidth.toString(),
                  onChanged: (value) {
                    setStateDialog(() {
                      _defaultWidth = value.round();
                    });
                  },
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Done'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['English', 'Français'].map((lang) {
            return RadioListTile<String>(
              title: Text(lang),
              value: lang,
              groupValue: _language,
              onChanged: (value) {
                setState(() => _language = value!);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}