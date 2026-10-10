#!/usr/bin/env bash
: '
'

cd "$HOME"
rm -rf .config/yadm
rm -r .config/bash
rm -r .config/fish
rm -r .config/nushell
rm -rf .local/share/yadm
rm -f .local/bin/yadm
rm .vimrc README.md df-cleanup.sh df-init.sh

