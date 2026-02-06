# Claude Code Team Onboarding Example

This is a reference implementation showing how to configure a repository for instant team onboarding with [Claude Code](https://claude.ai/code). It accompanies the blog post [Ship Standards, Not Wikis](https://blog.yazan.io/blog/2026-02-06-team-onboarding-claude-code).

## What's Inside

```
.
├── CLAUDE.md                              # Root standards (tech stack, conventions, git rules)
├── packages/
│   ├── api/CLAUDE.md                      # Backend-specific conventions
│   └── web/CLAUDE.md                      # Frontend-specific conventions
├── .claude/
│   ├── settings.json                      # Plugin config + hook definitions
│   └── skills/
│       ├── deploy/SKILL.md                # /deploy — deployment workflow
│       ├── new-endpoint/SKILL.md          # /new-endpoint — API scaffold
│       ├── review/SKILL.md                # /review — PR review checklist
│       └── incident/SKILL.md             # /incident — incident response
└── scripts/
    ├── session-init.sh                    # SessionStart hook (env checks)
    ├── format-and-lint.sh                 # PostToolUse hook (auto-format)
    └── check-no-secrets.sh                # PreToolUse hook (secret detection)
```

## How It Works

When a developer clones this repo and opens Claude Code:

1. **Plugins** defined in `.claude/settings.json` are prompted for installation (TypeScript LSP, GitHub, Linear, internal design system docs).
2. **CLAUDE.md** files load automatically, giving Claude full context about the tech stack, coding standards, and conventions.
3. **SessionStart hook** runs `scripts/session-init.sh` to verify the environment (Node version, dependencies, git status).
4. **Skills** are available as slash commands (`/deploy`, `/new-endpoint`, `/review`, `/incident`) encoding the team's exact workflows.
5. **PreToolUse hook** runs `scripts/check-no-secrets.sh` before every file write to block accidental credential leaks.
6. **PostToolUse hook** runs `scripts/format-and-lint.sh` after every file write to keep code formatted.
7. **Stop hook** uses a prompt-based check to verify that tests were run before Claude finishes a task.

## Using This as a Template

1. **Fork or copy** this structure into your own repo.
2. **Edit `CLAUDE.md`** to reflect your actual tech stack and standards.
3. **Customize the skills** to match your team's workflows (or delete the ones you don't need).
4. **Update `.claude/settings.json`** with your plugin and marketplace configuration.
5. **Adapt the hook scripts** for your toolchain (your formatter, your linter, your secret patterns).

## Key Concepts

| Layer | Purpose | Files |
|:------|:--------|:------|
| **CLAUDE.md** | Coding standards & context | `CLAUDE.md`, `packages/*/CLAUDE.md` |
| **Plugins** | Toolchain integrations | `.claude/settings.json` |
| **Skills** | Team workflows & rituals | `.claude/skills/*/SKILL.md` |
| **Hooks** | Automated enforcement | `.claude/settings.json` + `scripts/` |

## Learn More

- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
- [Skills Reference](https://docs.anthropic.com/en/docs/claude-code/skills)
- [Hooks Reference](https://docs.anthropic.com/en/docs/claude-code/hooks)
- [CLAUDE.md Best Practices](https://docs.anthropic.com/en/docs/claude-code/claude-md)
