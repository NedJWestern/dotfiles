# zsh reads this from $HOME before anything else; point it at the XDG config dir
export ZDOTDIR="$HOME/.config/zsh"

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
