: '
Managed by dotfiles repo in $HOME/.dotfiles/

https://github.com/NedJWestern/dotfiles/tree/master 
'

# exit on error
set -eu

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

# assert line exists in bashrc
LINE='source "$HOME"/.config/bash/bashrc'
grep -qF "$LINE" ~/.bashrc || echo "$LINE" >> ~/.bashrc

echo "Setup complete. Restart your shell or run 'source ~/.bashrc'"

