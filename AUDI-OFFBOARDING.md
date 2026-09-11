# Audi offboarding checklist

Repo-maintenance doc (not applied to `$HOME` — see `.chezmoiignore`). When the
Accenture/Audi engagement ends, work through this list to remove every
Audi-specific touch from this dotfiles repo.

## Isolated (delete a folder + remove its wiring)

1. `dot_config/zsh/audi/` — see its own `README.md` for exact steps
   (Keychain-backed AWS creds, `audi-bedrock()` function, named-dir shortcut)
2. `dot_config/git/audi/` — see its own `README.md` for exact steps
   (`git maintenance` repo registrations)

## Not isolatable (edit in place, no include/composition support)

3. `dot_config/starship.toml` — remove the Audi directory substitution:
   ```
   '~/EDF/Audi/Arcade' = '~audi'
   ```
4. `dot_config/opencode/opencode.json` — remove:
   - the `amazon-bedrock` provider block (Audi AWS profile
     `844592952383_developer_eu-central-1`, region `eu-central-1`)
   - the `mcp.mcp-atlassian` entry (Audi Jira: `collaboration.msi.audi.com`,
     `AUDI_JIRA_PERSONAL_TOKEN`)
   - the `mcp.bork` entry (Accenture/Audi internal knowledge base)
5. `dot_config/opencode/commands/jira-issue.md` — delete the file entirely
   (Audi Jira lookup command, depends on the mcp-atlassian entry above)
6. `private_Library/private_Application Support/private_Code/User/settings.json` — remove/trim:
   - `projectManager.git.baseFolders: ["~/EDF/Audi/Arcade"]`
   - `"Audi"` entry in `projectManager.tags`

## Also consider

- Revoke/delete the two macOS Keychain entries (covered in
  `dot_config/zsh/audi/README.md`)
- Uninstall any Audi-only CLIs no longer needed (e.g. `awstoken`, `bork`)
- Review `dot_Brewfile` for Audi-only casks/formulae picked up in later
  Brewfile dumps
