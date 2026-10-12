# Instructions

Cmd                 | Descr
--                  | --
[space] r p         | open new REPL
Esc Esc Ctrl w w    | focus to editory 


# Dependencies

- ty
- ipython

# Terminals swallowing `<C-CR>`

Many terminals send Ctrl+Enter as a plain Enter, so the `<C-CR>` slime mapping never fires.
Test: in insert mode press `Ctrl+V` then `Ctrl+Enter`. `<C-CR>` means it works; `^M` means it's swallowed.

- VTE-based terminals (Linux Mint default: GNOME/MATE/Xfce Terminal) can't send it at all. Use Alt+Enter (`<M-CR>`) instead, which is mapped too.
- kitty, WezTerm, Ghostty, foot: work via the kitty keyboard protocol (enabled automatically by Neovim 0.11+).
- Ghostty binds Ctrl+Enter to fullscreen by default; add `keybind = ctrl+enter=unbind` to `~/.config/ghostty/config`.
- Windows Terminal: doesn't send it by default.
