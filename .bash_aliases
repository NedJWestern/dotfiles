# managed by dotfiles repo in $HOME/.dotfiles/
# https://github.com/NedJWestern/dotfiles/tree/master 
alias dfgit='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ll='ls -l --all --human --color'
alias gfs='git fetch --prune && git status'
alias gs='git status'
alias gl='git log --oneline --graph'
alias gla='git log --oneline --graph --all'
alias gd='git diff'
alias gba='git branch -a'
alias gcl='git config --list --show-scope'
alias spps='sudo podman ps -a --format "table {{.ID}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"'
alias spil='sudo podman image list --sort repository'
alias pil='podman image list --sort repository'
alias nwgrep='grep --exclude-dir=".git" --exclude-dir=".venv"'
alias gbmd='git branch --merged | grep -Ev "(^\*|^\+|master|main|dev)" | xargs --no-run-if-empty git branch -d'

