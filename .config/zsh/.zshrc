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

# vi keys: start in insert mode (viins), Esc for normal mode (vicmd)
bindkey -v
KEYTIMEOUT=1                # Esc reaches vicmd in 10ms, not the default 400ms

# up/down (and k/j in normal mode) search history by the prefix already typed
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
for km in viins vicmd; do
    bindkey -M $km '^[[A' up-line-or-beginning-search
    bindkey -M $km '^[[B' down-line-or-beginning-search
    bindkey -M $km '^[OA' up-line-or-beginning-search
    bindkey -M $km '^[OB' down-line-or-beginning-search
    # ctrl+arrows/delete by word; bash gets these from /etc/inputrc
    bindkey -M $km '^[[1;5D' backward-word
    bindkey -M $km '^[[1;5C' forward-word
    bindkey -M $km '^[[3;5~' kill-word
done
bindkey -M vicmd 'k' up-line-or-beginning-search
bindkey -M vicmd 'j' down-line-or-beginning-search

# Insert mode keeps the emacs keys worth having. The vi-* defaults for
# backspace, ctrl+w and ctrl+u stop at the point insert mode was entered.
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-kill-word    # ctrl+backspace
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^U' backward-kill-line
bindkey -M viins '^K' kill-line
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins '^Y' yank
bindkey -M viins '^R' history-incremental-search-backward
bindkey -M viins '^S' history-incremental-search-forward
bindkey -M viins '^[.' insert-last-word     # alt+.
bindkey -M viins '^Q' push-line

# open the line in $VISUAL/$EDITOR: v in normal mode, as in bash's vi mode,
# or ctrl+x ctrl+e from insert mode
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line
bindkey -M viins '^x^e' edit-command-line

# text objects for quotes and brackets: ci", da(, yi{ ... (not built in)
autoload -Uz select-bracketed select-quoted
zle -N select-bracketed
zle -N select-quoted
for km in viopp visual; do
    for c in {a,i}${(s..)^:-\'\"\`}; do bindkey -M $km -- $c select-quoted; done
    for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do bindkey -M $km -- $c select-bracketed; done
done
unset km c

# cursor shows the mode: block in normal mode, bar in insert mode
zle-keymap-select() {
    if [[ $KEYMAP == vicmd ]]; then print -n '\e[2 q'; else print -n '\e[6 q'; fi
}
zle-line-init() { print -n '\e[6 q'; }
zle -N zle-keymap-select
zle -N zle-line-init
# back to a block before each command runs, so programs start with the default
autoload -Uz add-zsh-hook
_cursor_block() { print -n '\e[2 q'; }
add-zsh-hook preexec _cursor_block

export EDITOR=nvim VISUAL=nvim

# shared with bash; the file sticks to syntax both shells accept
. "$HOME/.config/bash/aliases"

# green blue yellow, same as the bash PS1
PROMPT='%F{green}%n%f@%F{blue}%m%f %F{yellow}%1~%f %# '

unset ZSH_STATE_DIR ZSH_CACHE_DIR
