# dotfiles

Manage your dotfiles with git. 

Inspired by [this article](https://www.atlassian.com/git/tutorials/dotfiles).


Instructions:

    cd $HOME
    rm .bash_aliases .vimrc
    curl --silent --fail https://raw.githubusercontent.com/NedJWestern/dotfiles/master/df-init.sh | bash

To completely uninstall, do:

    cd $HOME
    rm -rf .dotfiles
    rm .bash_aliases .vimrc

