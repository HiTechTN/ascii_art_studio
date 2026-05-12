# Troubleshooting Guide

## Common Issues and Solutions

### Android

#### "Install from unknown sources" blocked
- Go to Settings > Security > Install unknown apps
- Enable for your file manager or browser
- Try using a different method to install

#### App crashes on startup
1. Clear app cache: Settings > Apps > ASCII Art Studio > Clear cache
2. Uninstall and reinstall the app
3. Check if your Android version is supported (Android 5.0+)

#### Image picker not working
- Ensure storage permissions are granted
- Check if Google Photos is updated
- Try a different image

### iOS

#### Build fails on Xcode
- Ensure you have the latest Xcode version
- Update CocoaPods: `pod repo update`
- Clean and rebuild: `flutter clean && flutter pub get`

#### App won't install on device
- Check your provisioning profile
- Ensure your device is registered
- Check code signing settings

### Web

#### Page loads but shows blank
- Clear browser cache
- Try a different browser
- Check console for errors (F12)

#### Web build not working
- Ensure you're using a modern browser
- Check if WebGL is enabled

### Desktop (Windows/macOS/Linux)

#### Build fails with missing dependencies
- Install Visual Studio Build Tools (Windows)
- Install required libraries (Linux):
  ```
  sudo apt-get install clang cmake ninja-build libgtk-3-dev
  ```

#### App window is blank
- Update your graphics drivers
- Try running in compatibility mode (Windows)

## Getting Help

If you're still having issues:

1. Check the [FAQ](FAQ)
2. Search existing [Issues](https://github.com/HiTechTN/ascii_art_studio/issues)
3. Create a new issue with:
   - Your device/platform
   - Steps to reproduce
   - Error messages
   - Screenshots

## Performance Tips

### For better performance:
- Close other apps while using ASCII Art Studio
- Use smaller images (under 5MB)
- Clear gallery regularly to free space
- Keep the app updated