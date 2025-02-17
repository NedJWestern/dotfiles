# dotfiles

Manage your dotfiles with git. 

Inspired by [this article](https://www.atlassian.com/git/tutorials/dotfiles).

Instructions:

    cd $HOME
    # backup these files separately if necessary
    rm .bash_aliases .vimrc
    curl --silent --fail https://raw.githubusercontent.com/NedJWestern/dotfiles/master/df-init.sh | bash
    source .bashrc

Manage dotfiles with standard git commands using the `dfgit` alias

    <edit .bash_aliases>
    dfgit add .bash_aliases
    dfgit commit -m 'Update bash aliases'
    dfgit push

To completely uninstall, do:

    cd $HOME
    rm -rf .dotfiles REAME.md df-init.sh .bash_aliases .vimrc .config/fish
