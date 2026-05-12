# ASCII Art Studio

A cross-platform application to convert images to ASCII art and generate stylized ASCII text banners.

[![Release](https://img.shields.io/github/v/release/HiTechTN/ascii_art_studio)](https://github.com/HiTechTN/ascii_art_studio/releases/latest)
[![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-blue)]()
[![License](https://img.shields.io/github/license/HiTechTN/ascii_art_studio)](LICENSE)

## ⭐ Try It Now

### Web Demo
To enable the web demo:
1. Go to **Settings → Pages** in the repository
2. Under "Build and deployment", select **Deploy from a branch**
3. Choose `master` branch and `/docs` folder
4. Click Save

Once enabled, the demo will be available at:
`https://hitechtn.github.io/ascii_art_studio/`

### Quick Demo (Copy/Paste)
Open [`docs/index.html`](docs/index.html) directly in your browser to see the landing page preview.

## ✨ Features

### Image to ASCII
- Upload images from gallery/camera
- Adjust resolution (30-250 characters)
- Multiple character sets (7 types)
- 10 color palettes
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

## 📥 Installation

### Android APK
Download from [Releases](https://github.com/HiTechTN/ascii_art_studio/releases)

### Build from Source
```bash
# Clone the repository
git clone https://github.com/HiTechTN/ascii_art_studio.git
cd ascii_art_studio

# Get dependencies
flutter pub get

# Build for your platform
flutter build apk        # Android
flutter build web       # Web
flutter build windows   # Windows
flutter build macos     # macOS
flutter build linux    # Linux
```

## 📖 Documentation

- [Getting Started](wiki/Getting-Started.md)
- [Image to ASCII Guide](wiki/Image-to-ASCII.md)
- [Text to ASCII Guide](wiki/Text-to-ASCII.md)
- [FAQ](wiki/FAQ.md)
- [Troubleshooting](wiki/Troubleshooting.md)

## 🖥️ Supported Platforms

| Platform | Status |
|----------|--------|
| 🤖 Android | APK Available |
| 🍎 iOS | Build from source |
| 🌐 Web | GitHub Pages |
| 🪟 Windows | Build from source |
| 🐧 Linux | Build from source |
| 💻 macOS | Build from source |

## 🛠️ Technology

- Flutter 3.x
- Material Design 3

## 📄 License

MIT License - See [LICENSE](LICENSE) for details

---

<p align="center">
  Made with ❤️ using Flutter
</p>