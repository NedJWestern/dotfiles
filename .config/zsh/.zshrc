# Found via ZDOTDIR=$HOME/.config/zsh (set in ~/.zshenv, or the environment)

# Keep state and cache out of $HOME too; zsh won't create these dirs itself
ZSH_STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/zsh"
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p "$ZSH_STATE_DIR" "$ZSH_CACHE_DIR"

# history
HISTFILE="$ZSH_STATE_DIR/history"
HISTSIZE=50000
SAVEHIST=50000
setopt share_history        # write immediately, read other sessions' entries
setopt hist_ignore_dups     # equivalent to bash's ignoredups
setopt hist_ignore_space    # equivalent to bash's ignorespace
setopt hist_reduce_blanks
setopt hist_verify          # !! expands into the line instead of running it

# completion
autoload -Uz compinit && compinit -d "$ZSH_CACHE_DIR/zcompdump"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # case-insensitive
zstyle ':completion:*' list-colors ''

# behaviour
setopt auto_cd              # bare directory name cds into it
setopt interactive_comments # allow # comments at the prompt, like bash
setopt no_beep

# emacs keys. Explicit, because zsh picks vi keys when $EDITOR or $VISUAL contains "vi"
bindkey -e

# up/down search history by the prefix already typed
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[OA' up-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search
# ctrl+arrows/delete/backspace by word; bash gets these from /etc/inputrc
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[3;5~' kill-word
bindkey '^H' backward-kill-word

# ctrl+x ctrl+e opens the line in $VISUAL/$EDITOR, as in bash
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

export EDITOR=nvim VISUAL=nvim

# shared with bash; the file sticks to syntax both shells accept
. "$HOME/.config/bash/aliases"

# green blue yellow, same as the bash PS1
PROMPT='%F{green}%n%f@%F{blue}%m%f %F{yellow}%1~%f %# '

# fzf keys: ctrl+r history, ctrl+t file path, alt+c cd. fzf < 0.48 has no --zsh,
# but Debian ships the same script.
eval "$(fzf --zsh 2>/dev/null || cat /usr/share/doc/fzf/examples/key-bindings.zsh 2>/dev/null)"
# z <part of a dir> jumps to the best match among dirs visited before
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

unset ZSH_STATE_DIR ZSH_CACHE_DIR
