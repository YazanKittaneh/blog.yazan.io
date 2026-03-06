# packages/api — API Package

> Supplements the root `CLAUDE.md`. These conventions apply only when working inside `packages/api/`.

## Structure
Every API resource follows this four-file pattern:
- `src/routes/<resource>/route.ts` — Request handling and response shaping
- `src/schemas/<resource>.ts` — Zod input/output validation
- `src/db/queries/<resource>.ts` — All database access (no SQL in route handlers)
- `src/__tests__/integration/<resource>.test.ts` — Integration tests

## Route Handler Rules
- Parse and validate input with the Zod schema before touching any logic
- Call `src/db/queries/` functions — never write raw SQL in a route handler
- Return typed responses using the `ApiResponse<T>` wrapper from `src/lib/response.ts`
- Wrap every handler with `withErrorHandler` from `src/lib/errors.ts`

## Auth
- All routes are authenticated by default via the `requireAuth` middleware
- Use `publicRoute()` wrapper only for explicitly public endpoints
- Never read `req.user` without first calling `requireAuth`
