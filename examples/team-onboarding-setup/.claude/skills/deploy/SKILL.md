---
name: deploy
description: Deploy the application to staging or production
disable-model-invocation: true
allowed-tools:
  - Bash
  - Read
---

# Deploy Workflow

Follow this checklist before any deployment.

## Pre-deploy Checks

1. Ensure you are on a clean working tree (`git status` shows no uncommitted changes).
2. Run the full test suite:
   ```bash
   pnpm test
   ```
3. Run the type checker:
   ```bash
   pnpm typecheck
   ```
4. Run the linter:
   ```bash
   pnpm lint
   ```
5. Confirm the current branch is up to date with `main`:
   ```bash
   git fetch origin main && git log HEAD..origin/main --oneline
   ```
   If there are upstream commits, rebase before deploying.
6. Check for pending database migrations:
   ```bash
   ls -la packages/api/prisma/migrations/
   ```
   If new migrations exist that haven't been applied to the target environment, flag them to the developer.

## Staging Deployment

1. Push the current branch to the staging remote:
   ```bash
   git push origin HEAD:staging
   ```
2. Wait for the deployment to complete — check the Vercel dashboard or run:
   ```bash
   gh run list --branch staging --limit 1
   ```
3. Run smoke tests against staging:
   ```bash
   pnpm test:smoke --env=staging
   ```
4. Report the staging URL and smoke test results to the developer.

## Production Deployment

Only deploy to production from the `main` branch.

1. Confirm you are on `main` and it is up to date:
   ```bash
   git checkout main && git pull origin main
   ```
2. Create a release tag using the current date:
   ```bash
   git tag -a v$(date +%Y.%m.%d.%H%M) -m "Release $(date +%Y-%m-%d)"
   ```
3. Push with tags:
   ```bash
   git push origin main --tags
   ```
4. Monitor the production deployment:
   ```bash
   gh run list --branch main --limit 1
   ```
5. Verify health checks pass:
   ```bash
   curl -sf https://api.acme.com/health | jq .
   ```
6. Post a summary in `#releases` including:
   - The release tag
   - A list of PRs included since the last release
   - Any migration notes
