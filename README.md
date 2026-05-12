# ASCII Art Studio

A cross-platform application to convert images to ASCII art and generate stylized ASCII text banners.

## Features

### Image to ASCII
- Upload images from gallery/camera
- Adjust resolution (30-250 characters)
- Multiple character sets (Standard, Detailed, Minimal, Binary, Dots, Blocks, Circles)
- 10 color palettes (Neon Green, Amber, Cyan, Pink, Matrix Green, White, Purple, Orange, Blue, Red)
- Brightness and contrast adjustments
- Export as TXT or HTML (colored)

### Text to ASCII Generator
- 7 font styles (Block, Banner, Standard, Slant, Lean, Script, Big)
- Color selection
- Copy to clipboard or save

### Additional Features
- Dark/Light theme support
- Gallery to view saved artworks
- Settings for default values

## Screenshots

<p align="center">
  <img src="screenshot1.png" width="200" alt="Screenshot 1">
  <img src="screenshot2.png" width="200" alt="Screenshot 2">
</p>

## Installation

### From APK
Download the latest APK from the releases section.

### Build from Source
```bash
# Clone the repository
git clone https://github.com/HiTechTN/ascii_art_studio.git
cd ascii_art_studio

# Get dependencies
flutter pub get

# Build APK
flutter build apk --debug
# or
flutter build apk --release
```

## Supported Platforms
- Android
- iOS
- Web
- Windows
- macOS
- Linux

## Technology
- Flutter 3.x
- Material Design 3

## License
MIT License