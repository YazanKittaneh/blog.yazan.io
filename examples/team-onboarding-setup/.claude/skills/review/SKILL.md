---
name: review
description: Review a pull request against team coding standards
disable-model-invocation: true
allowed-tools:
  - Bash
  - Read
  - Grep
  - Glob
---

# Pull Request Review

Review the current pull request against team standards. Be thorough but constructive.

## Step 1: Understand the Change

1. Read the PR description:
   ```bash
   gh pr view --json title,body,labels,files
   ```
2. Get the diff:
   ```bash
   gh pr diff
   ```
3. Check which files are affected and categorize the change (feature, bugfix, refactor, etc.).

## Step 2: Code Quality Checks

For each changed file, verify:

### Naming and Exports
- [ ] Named exports only (no default exports)
- [ ] Functions and variables use camelCase
- [ ] Types and interfaces use PascalCase
- [ ] Constants use UPPER_SNAKE_CASE
- [ ] File names use kebab-case

### TypeScript
- [ ] No `any` types introduced
- [ ] No `@ts-ignore` or `@ts-expect-error` without a comment explaining why
- [ ] New functions have JSDoc comments
- [ ] Zod schemas used for runtime validation at API boundaries

### Patterns
- [ ] Route handlers use `withErrorHandler` and `withAuth` middleware
- [ ] Database queries are in `src/db/queries/`, not inline in handlers
- [ ] No `console.log` — use the logger utility
- [ ] Error boundaries present around new route segments (web package)
- [ ] No direct `fetch` mocking in tests — use MSW

### Dependencies
- [ ] New dependencies have pinned exact versions
- [ ] PR description includes justification for any new dependency
- [ ] `pnpm audit` shows no new vulnerabilities

## Step 3: Test Coverage

1. Check that tests exist for the changed code:
   ```bash
   gh pr diff --name-only | while read f; do
     test_file="${f%.ts}.test.ts"
     if [ ! -f "$test_file" ]; then echo "Missing test: $test_file"; fi
   done
   ```
2. Verify test quality:
   - Happy path covered
   - Edge cases and error paths tested
   - Bug fixes include a regression test

## Step 4: Compile the Review

Produce a structured review with these sections:

### Summary
One paragraph describing what the PR does and whether it's ready to merge.

### Issues (must fix)
Concrete problems that must be addressed before merge. Reference specific files and lines.

### Suggestions (nice to have)
Non-blocking improvements. Prefix with "nit:" if purely stylistic.

### Questions
Anything unclear about the approach or intent. Ask rather than assume.

Post the review as a PR comment:
```bash
gh pr review --comment --body "<review content>"
```
