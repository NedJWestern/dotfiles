# dotfiles

Manage your dotfiles with git. 

Inspired by [this article](https://www.atlassian.com/git/tutorials/dotfiles).


Instructions:

    cd $HOME
    rm .bash_aliases .vimrc
    curl --silent --fail https://raw.githubusercontent.com/NedJWestern/dotfiles/master/df-init.sh | bash
    source .bashrc

To completely uninstall, do:

    cd $HOME
    rm -rf .dotfiles REAME.md df-init.sh .bash_aliases .vimrc
