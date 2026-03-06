# CLAUDE.md

> **This is a template.** Replace everything below with your team's actual standards.

## Tech Stack
- Next.js 14 with App Router
- TypeScript strict mode
- Tailwind CSS, no custom CSS files
- Prisma ORM with PostgreSQL

## Code Standards
- All new functions must have JSDoc comments
- Use named exports, never default exports
- Error boundaries around every route segment
- No `console.log` in production code—use the logger util at `src/lib/logger.ts`

## Testing
- Unit tests with Vitest, co-located with source files (`foo.test.ts` next to `foo.ts`)
- Integration tests in `__tests__/integration/`
- Minimum 80% branch coverage on new code
- Run tests with: `pnpm test`

## Git Conventions
- Conventional commits: `feat|fix|chore|docs(scope): message`
- Squash merge to main
- Branch naming: `team/ticket-slug` (e.g. `eng/PROJ-123-add-auth`)
- Never force-push to main

## Project Structure
- `src/app/` — Next.js App Router pages and API routes
- `src/components/` — Shared UI components
- `src/lib/` — Utilities and shared logic
- `src/db/` — Database queries (Prisma)
- `src/schemas/` — Zod validation schemas
