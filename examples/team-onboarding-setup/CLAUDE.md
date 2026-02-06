# Acme Corp Engineering Standards

## Tech Stack

- Next.js 14 with App Router
- TypeScript in strict mode (`"strict": true` in tsconfig)
- Tailwind CSS for styling — no custom CSS files
- Prisma ORM with PostgreSQL
- pnpm as the package manager

## Code Standards

- Use named exports everywhere. Never use default exports.
- All new functions must have JSDoc comments describing params and return values.
- No `console.log` in production code — use `src/lib/logger.ts` instead.
- Error boundaries around every route segment in the web package.
- Prefer `async/await` over `.then()` chains.
- No `any` types. Use `unknown` with type narrowing if the type is truly dynamic.

## File Organization

- Co-locate files by feature, not by type. A feature directory contains its components, hooks, utils, and tests together.
- Barrel exports (`index.ts`) only at package boundaries, never inside feature directories.
- Shared utilities go in `src/lib/`. Shared types go in `src/types/`.

## Testing

- Unit tests with Vitest, co-located next to the source file (`foo.ts` → `foo.test.ts`).
- Integration tests in `__tests__/integration/`.
- E2E tests with Playwright in `e2e/`.
- Minimum 80% branch coverage on all new code.
- Every bug fix must include a regression test.

## Git Conventions

- Conventional commits: `feat|fix|chore|docs|refactor|test(scope): message`
- Squash merge to `main` — PR title becomes the commit message.
- Branch naming: `<team>/<ticket-slug>` (e.g., `platform/ACME-1234-add-auth`).
- Never force push to `main` or `staging`.

## Pull Requests

- PRs must have a description explaining **what** changed and **why**.
- Include a test plan — what was tested and how.
- Tag at least one reviewer from the owning team.
- All CI checks must pass before merge.

## Dependencies

- Pin exact versions in `package.json` (no `^` or `~`).
- Dependency additions require a brief justification in the PR description.
- Run `pnpm audit` before adding any new dependency.
