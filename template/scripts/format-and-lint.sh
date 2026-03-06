#!/usr/bin/env bash
# PostToolUse hook: format and lint a file after Claude writes or edits it.
#
# Adapt this script to call your actual formatter and linter.
# The file path is passed as the first argument ($1).

set -euo pipefail

FILE="$1"

if [ -z "$FILE" ]; then
  echo "No file path provided" >&2
  exit 1
fi

# Only process files that exist (skip deletions)
if [ ! -f "$FILE" ]; then
  exit 0
fi

# Format with Prettier (replace with your formatter if different)
if command -v pnpm &>/dev/null; then
  pnpm prettier --write "$FILE" --log-level warn 2>/dev/null || true
fi

# Lint with ESLint (replace with your linter if different)
# --fix applies auto-fixable rules; errors that can't be auto-fixed are printed
if command -v pnpm &>/dev/null; then
  pnpm eslint --fix "$FILE" 2>/dev/null || true
fi
