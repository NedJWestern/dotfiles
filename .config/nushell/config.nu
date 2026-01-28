# config.nu
#
# Installed by:
# version = "0.103.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.
alias ll = ls -a
alias gs = git status
alias gd = git diff
alias gfs = git fetch; git status
alias gba = git branch --all
alias gl = git log --oneline --graph
alias gla = git log --oneline --graph --all
alias nwgrep = grep --color --exclude-dir=".git" --exclude-dir=".venv" --exclude-dir=".dvc"
# TODO check me
# alias gbdm = git branch --merged | lines | str trim | where ($it != "master" and $it != "* dev") | each { |b| git branch -d $b }
