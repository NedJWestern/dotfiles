# dotfiles

Manage your dotfiles with git, via [yadm](https://yadm.io).

Instructions:

```bash
curl --silent --fail https://raw.githubusercontent.com/NedJWestern/dotfiles/master/df-init.sh | bash
```

If `yadm` isn't already installed (e.g. no package manager available), it's downloaded straight into `~/.local/bin/yadm`. Make sure that directory is on your `PATH` for future shells.

Any conflicting existing files are backed up automatically to `~/.local/share/yadm/backup/`.

Manage dotfiles with standard git commands using `yadm`

```bash
<edit .bash_aliases>
yadm add .bash_aliases
yadm commit -m 'Update bash aliases'
yadm push
```

To completely uninstall or cleanup files, do:

```bash
curl --silent --fail https://raw.githubusercontent.com/NedJWestern/dotfiles/master/df-cleanup.sh | bash
```

