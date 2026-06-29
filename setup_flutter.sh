#!/usr/bin/env bash
set -euo pipefail

FLUTTER_DIR="$PWD/flutter_sdk"

if command -v flutter &>/dev/null; then
  echo "Flutter already installed: $(flutter --version | head -1)"
  exit 0
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  ARCH=$(uname -m)
  if [[ "$ARCH" == "arm64" ]]; then
    URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64-stable.zip"
  else
    URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_x64-stable.zip"
  fi
else
  echo "This setup script is intended for macOS. For Linux/Windows, see https://docs.flutter.dev/get-started/install"
  exit 1
fi

echo "Downloading Flutter SDK..."
curl -L -o flutter_sdk.zip "$URL"
unzip -q flutter_sdk.zip -d flutter_sdk_tmp
mv flutter_sdk_tmp/flutter "$FLUTTER_DIR"
rm -rf flutter_sdk_tmp flutter_sdk.zip

echo "Adding Flutter to PATH for this session:"
export PATH="$FLUTTER_DIR/bin:$PATH"
echo "export PATH=\"$FLUTTER_DIR/bin:\$PATH\"" >> ~/.zshrc

echo "Running flutter doctor..."
flutter doctor

echo "Flutter setup complete. Restart your terminal or run:"
echo "  export PATH=\"$FLUTTER_DIR/bin:\$PATH\""
