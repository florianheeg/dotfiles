#!/bin/sh
# Registers a launchd agent that runs ~/.local/bin/brew-check every 6 hours
# (AC power only) so Starship's outdated-package hint stays fresh. Also
# starts `brew autoupdate` for index-refresh-only background updates.
#
# Managed by chezmoi as run_onchange_: re-runs automatically if this script's
# content changes; safe to re-run any time (idempotent).

set -eu

PLIST_LABEL="com.dotfiles.brew-check"
INTERVAL_SECONDS=21600 # 6 hours
BREW_CHECK_PATH="$HOME/.local/bin/brew-check"
LAUNCH_AGENTS_DIR="$HOME/Library/LaunchAgents"
PLIST_PATH="$LAUNCH_AGENTS_DIR/$PLIST_LABEL.plist"
LOG_PATH="/tmp/$PLIST_LABEL.log"

command -v brew >/dev/null 2>&1 || { echo "Homebrew not found, skipping brew-check launchd setup" >&2; exit 0; }

# 1. Start brew autoupdate (index refresh only, no --upgrade) if not already running
if brew autoupdate status 2>/dev/null | grep -q "not configured"; then
  brew autoupdate start "$INTERVAL_SECONDS" --immediate --ac-only
fi

# 2. Write the brew-check launchd plist with the resolved absolute path
#    (launchd does not expand ~ or env vars in Program keys)
mkdir -p "$LAUNCH_AGENTS_DIR"
cat > "$PLIST_PATH" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>$PLIST_LABEL</string>
  <key>Program</key>
  <string>$BREW_CHECK_PATH</string>
  <key>ProgramArguments</key>
  <array>
    <string>$BREW_CHECK_PATH</string>
  </array>
  <key>StartInterval</key>
  <integer>$INTERVAL_SECONDS</integer>
  <key>RunAtLoad</key>
  <true/>
  <key>StandardOutPath</key>
  <string>$LOG_PATH</string>
  <key>StandardErrorPath</key>
  <string>$LOG_PATH</string>
  <key>LowPriorityBackgroundIO</key>
  <true/>
  <key>LowPriorityIO</key>
  <true/>
  <key>ProcessType</key>
  <string>Background</string>
  <key>Condition</key>
  <dict>
    <key>OnACPower</key>
    <true/>
  </dict>
</dict>
</plist>
EOF

# 3. Load (or reload) the plist — unload first to pick up any changes
/bin/launchctl unload "$PLIST_PATH" 2>/dev/null || true
/bin/launchctl load "$PLIST_PATH"

# 4. Run brew-check immediately to populate the cache
"$BREW_CHECK_PATH"
