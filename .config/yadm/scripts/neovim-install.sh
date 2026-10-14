#!/usr/bin/env bash
set -euo pipefail

ARCH=$(uname -m)
case "$ARCH" in
  x86_64) ASSET="nvim-linux-x86_64.tar.gz" ;;
  aarch64) ASSET="nvim-linux-arm64.tar.gz" ;;
  *) echo "Unsupported architecture: $ARCH" >&2; exit 1 ;;
esac

URL="https://github.com/neovim/neovim/releases/latest/download/${ASSET}"
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

INSTALL_DIR="$HOME/.local/opt/nvim"
BIN_DIR="$HOME/.local/bin"

echo "Downloading latest Neovim release for $ARCH..."
curl -fL "$URL" -o "$TMP_DIR/$ASSET"

echo "Installing to $INSTALL_DIR..."
rm -rf "$INSTALL_DIR"
mkdir -p "$HOME/.local/opt" "$BIN_DIR"
tar -C "$HOME/.local/opt" -xzf "$TMP_DIR/$ASSET"
mv "$HOME/.local/opt/${ASSET%.tar.gz}" "$INSTALL_DIR"

ln -sf "$INSTALL_DIR/bin/nvim" "$BIN_DIR/nvim"

case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *) echo "Note: $BIN_DIR is not in your PATH. Add 'export PATH=\"$BIN_DIR:\$PATH\"' to your shell profile." ;;
esac

echo "Installed: $("$BIN_DIR/nvim" --version | head -n1)"
