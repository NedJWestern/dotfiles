: '
Custom bash functions

This file is managed by the dotfiles repository
'

# Function to set password from secure input
set_quick_pass() {
    echo -n "Quick password: "
    read -s QUICK_PASS
    export QUICK_PASS
    echo
    bind "\"\C-xx\": \"$QUICK_PASS\""
}

sudo_with_stored_pass() {
    echo "$QUICK_PASS" | sudo -p '' -S "$@"
}

alias qpass='set_quick_pass'
alias ssudo='sudo_with_stored_pass'

