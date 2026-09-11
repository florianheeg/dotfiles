# General
hash -d private="$HOME/EDF/Privat"
hash -d dotfiles="$HOME/.local/share/chezmoi"
hash -d workspaces="$HOME/EDF/workspaces"

# Audi-specific setup — see ~/.config/zsh/audi/README.md for offboarding steps
[ -d "$HOME/EDF/Audi/Arcade" ] && hash -d audi="$HOME/EDF/Audi/Arcade"
