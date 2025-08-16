: '
Custom bash functions

This file is managed by the dotfiles repository
'

# Function to set password from secure input
set_quick_pass() {
    echo -n "Quick password: "
    read -s QUICK_PASS
    echo
    bind "\"\C-xx\": \"$QUICK_PASS\""
}


alias qpass='set_quick_pass'

