: '
Managed by dotfiles repo, using yadm (https://yadm.io)

https://github.com/NedJWestern/dotfiles-omarchy/tree/master
'

set -eu

if ! command -v yadm >/dev/null 2>&1; then
    echo "yadm not found, installing to \$HOME/.local/bin/yadm"
    mkdir -p "$HOME"/.local/bin
    curl -fLo "$HOME"/.local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm
    chmod a+x "$HOME"/.local/bin/yadm
    export PATH="$HOME/.local/bin:$PATH"
fi

# clones, backs up any conflicting existing files, and runs the bootstrap script
yadm clone --bootstrap https://github.com/NedJWestern/dotfiles.git

echo
echo "Setup complete. Restart your shell or run 'source "$HOME"/.bashrc'"
