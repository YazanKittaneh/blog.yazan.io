# API Package

This package contains the backend REST API built with Next.js Route Handlers.

## Architecture

- Route handlers live in `src/app/api/<resource>/route.ts`.
- Each resource has a Zod schema in `src/schemas/<resource>.ts`.
- Database queries are isolated in `src/db/queries/<resource>.ts` — never write raw SQL in route handlers.
- Shared middleware lives in `src/middleware/`.

## Conventions

- All endpoints return responses wrapped in `ApiResponse<T>` from `src/lib/api-response.ts`.
- Use `withErrorHandler` middleware on every route handler for consistent error formatting.
- Authentication is handled by the `withAuth` middleware — never check tokens manually.
- Rate limiting configuration lives in `src/config/rate-limits.ts`.

## Database

- Prisma is the ORM. Schema lives at `prisma/schema.prisma`.
- Migrations are created with `pnpm prisma migrate dev --name <description>`.
- Seed data lives in `prisma/seed.ts`.
- Never modify a migration after it has been merged to `main`.

## Testing

- Integration tests hit a test database (configured via `DATABASE_URL_TEST` in `.env.test`).
- Use the `createTestClient()` helper from `src/test-utils/` for API tests.
- Mock external services using MSW (Mock Service Worker) — never mock `fetch` directly.
