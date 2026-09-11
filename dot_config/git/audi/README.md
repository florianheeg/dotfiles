# Audi-specific git config

See `/AUDI-OFFBOARDING.md` at the repo root for the full offboarding checklist
across all config files.

`maintenance.gitconfig` registers Audi project repos for `git maintenance`
(background gc/fetch scheduling). It's included unconditionally from
`~/.gitconfig` (source: `dot_gitconfig`) via:

```
[include]
	path = ~/.config/git/audi/maintenance.gitconfig
```

Git silently ignores a missing include path, so offboarding is just:

1. Delete this folder: `~/.config/git/audi/` (source: `dot_config/git/audi/`)
2. Remove the `[include]` block above from `~/.gitconfig`
3. Run `git maintenance unregister --config` in each listed repo if you want
   to stop scheduled maintenance immediately rather than waiting for it to
   no-op silently.
