---
name: new-endpoint
description: Scaffold a new API endpoint following team conventions
---

# New API Endpoint

> **Adapt this skill:** Update the file paths and template details to match your project's actual structure.

When creating a new endpoint, follow this structure:

1. Create the route handler in `src/app/api/<resource>/route.ts`
2. Define the Zod schema in `src/schemas/<resource>.ts`
3. Add the database query in `src/db/queries/<resource>.ts`
4. Create the integration test in `src/__tests__/integration/<resource>.test.ts`
5. Add the endpoint to the OpenAPI spec in `docs/api.yaml`

## Route Handler Template

Use this structure for all route handlers:

- Parse and validate the request body with the Zod schema (fail fast on invalid input)
- Call the database query function — never write SQL in the handler
- Return a typed response using the `ApiResponse<T>` wrapper from `src/lib/response.ts`
- Handle errors with the `withErrorHandler` middleware from `src/lib/errors.ts`

## Testing Requirements

Every endpoint needs tests covering:

- The happy path (valid input, expected output)
- Validation failures (malformed or missing fields)
- Authorization (missing token, expired token, insufficient permissions)
- Not-found cases for resource lookups (return 404, not 500)
