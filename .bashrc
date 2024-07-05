# managed by dotfiles repo in .cfg
# https://www.atlassian.com/git/tutorials/dotfiles
alias dotfiles='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias gfs='git fetch && git status'
alias gs='git status'
alias gl='git log --oneline --graph'
alias gla='git log --oneline --graph --all'
alias gd='git diff'
alias ll='ls -alh'
alias sp='sudo podman'
alias spps='sudo podman ps -a --format "table {{.ID}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"'
