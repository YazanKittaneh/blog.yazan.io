#!/usr/bin/env bash
#
# SessionStart hook: Initialize context at the beginning of every Claude Code session.
# Loads current sprint info, checks environment, and reports status.
#

set -euo pipefail

MESSAGES=()

# Check Node.js version
REQUIRED_NODE="20"
CURRENT_NODE=$(node --version 2>/dev/null | cut -d'.' -f1 | tr -d 'v' || echo "0")
if [ "$CURRENT_NODE" -lt "$REQUIRED_NODE" ]; then
  MESSAGES+=("Node.js $REQUIRED_NODE+ required (found v$CURRENT_NODE). Run 'nvm use' to switch.")
fi

# Check that dependencies are installed
if [ ! -d "node_modules" ]; then
  MESSAGES+=("Dependencies not installed. Run 'pnpm install' first.")
fi

# Check for uncommitted changes
if ! git diff --quiet 2>/dev/null; then
  CHANGED=$(git diff --stat --shortstat 2>/dev/null)
  MESSAGES+=("Uncommitted changes detected: $CHANGED")
fi

# Check how far behind main we are
BEHIND=$(git rev-list --count HEAD..origin/main 2>/dev/null || echo "unknown")
if [ "$BEHIND" != "0" ] && [ "$BEHIND" != "unknown" ]; then
  MESSAGES+=("Current branch is $BEHIND commit(s) behind main. Consider rebasing.")
fi

# Report status
if [ ${#MESSAGES[@]} -gt 0 ]; then
  OUTPUT=""
  for MSG in "${MESSAGES[@]}"; do
    OUTPUT+="- $MSG\n"
  done
  echo -e "{\"message\": \"Session notes:\\n$OUTPUT\"}"
else
  BRANCH=$(git branch --show-current 2>/dev/null || echo "unknown")
  echo "{\"message\": \"Environment OK. Branch: $BRANCH\"}"
fi

exit 0
