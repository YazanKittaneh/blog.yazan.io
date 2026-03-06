---
name: review
description: Run through the PR review checklist before opening or merging a pull request
---

# PR Review Checklist

> **Adapt this skill:** Replace the checklist items with your team's actual review standards.

Run through the following before opening a pull request or approving one.

## Before Opening a PR

- [ ] All new functions have JSDoc comments
- [ ] Named exports used throughout (no default exports)
- [ ] Tests written and passing (`pnpm test`)
- [ ] Types check cleanly (`pnpm typecheck`)
- [ ] No `console.log` statements left in the code
- [ ] Branch is up to date with main
- [ ] PR description explains *why* the change was made, not just *what* changed

## During Review

- [ ] Does the change do what the PR description says it does?
- [ ] Are there edge cases the tests don't cover?
- [ ] Is the error handling appropriate?
- [ ] Could this be simpler?
- [ ] Are any new dependencies justified?

## Database Changes

If the PR includes database migrations:

- [ ] Migration is reversible (or non-reversible migration is explicitly documented)
- [ ] Migration has been tested against a copy of production data
- [ ] Indexes added for any new query patterns

## API Changes

If the PR adds or modifies API endpoints:

- [ ] Endpoint is documented in `docs/api.yaml`
- [ ] Breaking changes are flagged in the PR description
- [ ] Auth requirements are explicitly set
