# dotfiles

Manage your dotfiles with git. 

Inspired by [this article](https://www.atlassian.com/git/tutorials/dotfiles).

Instructions:

Backup any conflicting files as necessary

```bash
curl --silent --fail https://raw.githubusercontent.com/NedJWestern/dotfiles/master/df-init.sh | bash
```

Manage dotfiles with standard git commands using the `dfgit` alias

```bash
<edit .bash_aliases>
dfgit add .bash_aliases
dfgit commit -m 'Update bash aliases'
dfgit push
```

To completely uninstall or cleanup files, do:

```bash
curl --silent --fail https://raw.githubusercontent.com/NedJWestern/dotfiles/master/df-cleanup.sh | bash
```

