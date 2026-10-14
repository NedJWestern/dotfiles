#!/usr/bin/env bash
: '
Managed by dotfiles repo, using yadm (https://yadm.io)

https://github.com/NedJWestern/dotfiles

Usage:
curl --silent --fail https://raw.githubusercontent.com/NedJWestern/dotfiles/master/.config/yadm/scripts/df-cleanup.sh | bash
'

set -eu

cd "$HOME"

# yadm-managed config
rm -rf .config/yadm
rm -rf .config/bash
rm -rf .config/nushell
rm -rf .config/nvim
rm -rf .config/ghostty
rm -f .vimrc README.md

# line added to .bashrc by .config/yadm/bootstrap
if [ -f .bashrc ]; then
    grep -vF 'source "$HOME"/.config/bash/bashrc' .bashrc > .bashrc.tmp
    mv .bashrc.tmp .bashrc
fi

# yadm itself
rm -rf .local/share/yadm
rm -f .local/bin/yadm

# installed by .config/yadm/scripts/neovim-install.sh
rm -rf .local/opt/nvim
rm -f .local/bin/nvim

echo
echo "Cleanup complete."

