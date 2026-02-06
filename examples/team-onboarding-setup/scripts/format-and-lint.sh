#!/usr/bin/env bash
#
# PostToolUse hook: Format and lint files after every write/edit.
# Receives tool result as JSON on stdin.
# Runs Prettier and ESLint on the affected file.
#

set -euo pipefail

INPUT=$(cat)

# Extract the file path from the tool result
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [ -z "$FILE_PATH" ] || [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

# Only process TypeScript, JavaScript, and JSON files
case "$FILE_PATH" in
  *.ts|*.tsx|*.js|*.jsx|*.json|*.css)
    ;;
  *)
    exit 0
    ;;
esac

# Run Prettier
if command -v pnpm &>/dev/null && [ -f "node_modules/.bin/prettier" ]; then
  pnpm prettier --write "$FILE_PATH" 2>/dev/null || true
fi

# Run ESLint with auto-fix (skip for JSON and CSS)
case "$FILE_PATH" in
  *.ts|*.tsx|*.js|*.jsx)
    if command -v pnpm &>/dev/null && [ -f "node_modules/.bin/eslint" ]; then
      pnpm eslint --fix "$FILE_PATH" 2>/dev/null || true
    fi
    ;;
esac

exit 0
