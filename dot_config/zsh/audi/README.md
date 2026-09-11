# Audi-specific shell config

Everything in this folder exists only because of the Accenture/Audi engagement.
See `/AUDI-OFFBOARDING.md` at the repo root for the full offboarding checklist
across all config files. This folder's own removal steps:

1. Delete this folder: `~/.config/zsh/audi/` (source: `dot_config/zsh/audi/` in chezmoi)
2. Remove the sourcing line from `~/.zprofile` (source: `dot_zprofile`):
   ```
   [ -f "$HOME/.config/zsh/audi/keychain.zsh" ] && source "$HOME/.config/zsh/audi/keychain.zsh"
   ```
3. Remove the sourcing line from `~/.zshrc` (source: `dot_zshrc`):
   ```
   [ -f "$HOME/.config/zsh/audi/bedrock.zsh" ] && source "$HOME/.config/zsh/audi/bedrock.zsh"
   ```
4. Remove the audi `hash -d` line from `~/.config/zsh/named-dirs.zsh`
   (source: `dot_config/zsh/named-dirs.zsh`):
   ```
   [ -d "$HOME/EDF/Audi/Arcade" ] && hash -d audi="$HOME/EDF/Audi/Arcade"
   ```

Also drop the two Keychain entries themselves if you no longer need them:

```sh
security delete-generic-password -s "audi-bedrock-kums-id"
security delete-generic-password -s "audi-bedrock-arn-role"
```

## Files

- `keychain.zsh` — exports `VW_KUMS_ID`/`AWS_ROLE_ARN` from macOS Keychain, sourced from `~/.zprofile`
- `bedrock.zsh` — the `audi-bedrock()` shell function (wraps `awstoken`), sourced from `~/.zshrc`
