# claude-code-team-template

A ready-to-use template demonstrating how to configure Claude Code for an engineering team. Clone it, adapt it to your stack, and commit it to your own repo.

Accompanies the blog series **[Ship Standards, Not Wikis](https://blog.yazan.io/blog/2026-02-06-team-onboarding-claude-code)**.

---

## What's in here

```
.
├── CLAUDE.md                          # Team-wide standards (tech stack, conventions, git)
├── packages/
│   ├── api/CLAUDE.md                  # API package conventions
│   └── web/CLAUDE.md                  # Frontend package conventions
├── .claude/
│   ├── settings.json                  # Plugin declarations + hooks
│   └── skills/
│       ├── deploy/SKILL.md            # /deploy — staging and production deploy workflow
│       ├── new-endpoint/SKILL.md      # scaffolds a new API endpoint
│       ├── review/SKILL.md            # /review — PR review checklist
│       └── incident/SKILL.md          # /incident — incident response runbook
└── scripts/
    ├── format-and-lint.sh             # Run by PostToolUse hook after every file edit
    └── check-no-secrets.sh            # Run by PreToolUse hook before every file write
```

## How to use it

1. **Copy** the files you need into your own repository. You don't have to use all of them.
2. **Edit `CLAUDE.md`** to match your actual tech stack, coding standards, and git workflow.
3. **Edit `.claude/settings.json`** to reference the plugins your project actually uses.
4. **Edit the skills** to match your team's real workflows. The deploy skill in particular will need your actual commands and URLs.
5. **Adapt the scripts** to call your real formatter and linter.
6. **Commit everything.** The whole point is that these files live in version control alongside your code.

## The series

- [Part 1: The Foundation — CLAUDE.md](https://blog.yazan.io/blog/2026-02-06-team-onboarding-claude-code)
- [Part 2: Plugins and the Marketplace](https://blog.yazan.io/blog/2026-02-13-team-onboarding-plugins)
- [Part 3: Skills: Encoding Team Rituals](https://blog.yazan.io/blog/2026-02-20-team-onboarding-skills)
- [Part 4: Hooks and Putting It All Together](https://blog.yazan.io/blog/2026-02-27-team-onboarding-hooks)
