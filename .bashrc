# managed by dotfiles repo in $HOME/.dotfiles/
# https://www.atlassian.com/git/tutorials/dotfiles
alias dgit='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ll='ls -l --all --human --color'
alias gfs='git fetch && git status'
alias gs='git status'
alias gl='git log --oneline --graph'
alias gla='git log --oneline --graph --all'
alias gd='git diff'
alias sp='sudo podman'
alias spps='sudo podman ps -a --format "table {{.ID}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"'

