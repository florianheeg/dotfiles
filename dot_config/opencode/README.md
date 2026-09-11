# OpenCode Configuration

This directory is intended to be symlinked to `~/.config/opencode`.

## Structure

```
.
├── opencode.json    # Main configuration
├── tui.json         # TUI settings
├── AGENTS.md        # Global instructions
├── agents/          # Custom agent definitions
├── commands/        # Custom slash commands
├── skills/          # Reusable behavior workflows
└── themes/          # Custom UI themes
```

## Configuration

- `opencode.json` - Core settings (models, providers, tools, permissions)
- `tui.json` - Terminal UI customization (themes, keybinds)
- `AGENTS.md` - Global instructions applied to all sessions

## Per-Project Override

Place an `opencode.json` or `.opencode/` directory in project root to override global settings.

## Session Reflection System

A self-improving workflow that captures session learnings and identifies patterns over time.

### Workflow

1. **Reflect** - Run `/reflect` after meaningful work sessions to capture what happened
2. **Evolve** - Run `/evolve-workflow` periodically to detect patterns and suggest improvements
3. **Improve** - Insights are incorporated into AGENTS.md for better future sessions

### Commands

| Command | Description |
|---------|-------------|
| `/reflect` | Start a guided session reflection |
| `/evolve-workflow` | Analyze past reflections for patterns and improvements |

### Skills

| Skill | Description |
|-------|-------------|
| `reflect-session` | Guided reflection workflow with auto-context detection |
| `evolve-workflow` | Pattern analysis across past reflections |

### Storage

Reflections are stored in: `~/.local/share/opencode/darwin-reflections/`

File naming: `YYYY-MM-DD--[uuid].md`

### Pattern Detection

After 3+ sessions, the evolve-workflow skill can identify:
- Recurring user preferences
- Repeated requests (candidates for new commands)
- Friction points and workarounds
- Autonomy trends

Improvements suggested by the skill can be:
- Added to AGENTS.md as rules or guidelines
- Created as new skills or commands
- Added to the improvement backlog
