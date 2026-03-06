---
name: deploy
description: Deploy to staging or production environment
disable-model-invocation: true
allowed-tools:
  - Bash
  - Read
---

# Deploy Workflow

> **Adapt this skill:** Replace the URLs, branch names, and commands with your team's real deployment setup.

Before deploying, verify the following:

1. Run the full test suite: `pnpm test`
2. Run the type checker: `pnpm typecheck`
3. Confirm the current branch is up to date with main: `git fetch origin && git status`
4. Check for any pending database migrations in `prisma/migrations/`

## Staging

- Push to the `staging` branch: `git push origin HEAD:staging`
- Monitor the deploy at https://vercel.com/your-org/your-app/deployments
- Run smoke tests: `pnpm test:smoke --env=staging`
- Verify the staging URL is responding correctly

## Production

- Ensure staging has been verified and signed off
- Create a release tag: `git tag -a v$(date +%Y.%m.%d) -m "Release $(date +%Y.%m.%d)"`
- Push with tags: `git push origin main --tags`
- Monitor the deploy in Vercel and verify health checks pass
- Post in #releases with a summary of what changed
