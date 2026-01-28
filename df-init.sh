# managed by dotfiles repo in $HOME/.dotfiles/
# https://github.com/NedJWestern/dotfiles/tree/master 

# exit on error
set -e

if [[ -f ~/.bash_aliases ]] || [[ -f ~/.vimrc ]]; then
    echo ERROR: Please first remove or backup these files: .bash_aliases, .vimrc
    exit 1
fi

# prevent git recursion issues
echo ".dotfiles" > $HOME/.gitignore

# clone and setup git repo
git clone --bare https://github.com/NedJWestern/dotfiles.git $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no

# Add sourcing of bash aliases
if ! grep -q ".bash_aliases" ~/.bashrc; then

    cat << 'EOT' >> ~/.bashrc

source $HOME/.bash_aliases

EOT
fi

