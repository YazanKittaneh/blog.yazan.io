#!/usr/bin/env bash
# PreToolUse hook: block file writes that contain secrets.
#
# Claude passes the content to be written via stdin.
# Exit with a non-zero code to block the write and send an error to Claude.
# Exit with 0 to allow the write to proceed.

set -euo pipefail

CONTENT=$(cat)

# Patterns that look like secrets
PATTERNS=(
  # Generic API key patterns
  'sk-[a-zA-Z0-9]{20,}'
  'pk_live_[a-zA-Z0-9]+'
  'pk_test_[a-zA-Z0-9]+'
  # AWS
  'AKIA[0-9A-Z]{16}'
  'aws_secret_access_key\s*=\s*[^\s]+'
  # Generic high-entropy assignments
  'SECRET\s*=\s*["\047][a-zA-Z0-9/+]{32,}'
  'TOKEN\s*=\s*["\047][a-zA-Z0-9/+]{32,}'
  'PASSWORD\s*=\s*["\047][^\s"'\'']{8,}'
)

for pattern in "${PATTERNS[@]}"; do
  if echo "$CONTENT" | grep -qiE "$pattern"; then
    echo "Blocked: content matches secret pattern: $pattern" >&2
    echo "Remove the secret before writing this file. Use environment variables or a secrets manager instead." >&2
    exit 1
  fi
done

exit 0
