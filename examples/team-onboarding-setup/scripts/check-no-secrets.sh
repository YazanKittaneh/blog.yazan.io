#!/usr/bin/env bash
#
# PreToolUse hook: Block file writes that contain secrets.
# Receives tool input as JSON on stdin.
# Exit 0 to allow, exit 2 to block (with reason on stdout).
#

set -euo pipefail

INPUT=$(cat)

# Extract the file content from the tool input
CONTENT=$(echo "$INPUT" | jq -r '.tool_input.content // .tool_input.new_string // empty')

if [ -z "$CONTENT" ]; then
  exit 0
fi

# Patterns that indicate secrets or credentials
PATTERNS=(
  # AWS
  'AKIA[0-9A-Z]{16}'
  'aws_secret_access_key'
  # Generic API keys and tokens
  'sk-[a-zA-Z0-9]{20,}'
  'ghp_[a-zA-Z0-9]{36}'
  'gho_[a-zA-Z0-9]{36}'
  'github_pat_[a-zA-Z0-9_]{22,}'
  # Private keys
  '-----BEGIN (RSA |EC |DSA )?PRIVATE KEY-----'
  # Database URLs with credentials
  'postgres(ql)?://[^:]+:[^@]+@'
  'mysql://[^:]+:[^@]+@'
  # Generic secret patterns
  'password\s*[:=]\s*["\x27][^"\x27]{8,}'
  'secret\s*[:=]\s*["\x27][^"\x27]{8,}'
  'api[_-]?key\s*[:=]\s*["\x27][^"\x27]{8,}'
)

for PATTERN in "${PATTERNS[@]}"; do
  if echo "$CONTENT" | grep -qiP "$PATTERN" 2>/dev/null; then
    echo "{\"decision\": \"block\", \"reason\": \"Potential secret detected matching pattern: $PATTERN. Use environment variables or a secrets manager instead of hardcoding credentials.\"}"
    exit 2
  fi
done

exit 0
