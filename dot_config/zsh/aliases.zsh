# find / grep
alias fdd="fd"
alias rgg="rg"

# Homebrew — refresh outdated cache after upgrade
brew() {
  command brew "$@"
  local exit_code=$?
  if [[ "$1" == "upgrade" ]]; then
    brew-check
  fi
  return $exit_code
}

# Git
alias ga="git add"
alias gb="git branch"
alias gc="git commit --verbose"
alias gcm="gc --message"
alias gco="git checkout"
alias gc!='gc --amend'
alias gcn!="gc! --no-edit"
alias gd="git diff"
alias glg="git log --oneline --graph --decorate"
alias gp='git push'
alias gpf!='git push --force-with-lease'
alias gpd='git push --dry-run'
alias gpl='git pull'
alias gst="git status"

# Caffeinate — keep Mac awake (default action)
alias decaf="$HOME/.local/bin/caffeine stop"

# STO
alias sto="pnpx @asg-song/sto-cli"
