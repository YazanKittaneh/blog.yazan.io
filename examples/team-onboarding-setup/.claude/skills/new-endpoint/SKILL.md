---
name: new-endpoint
description: Scaffold a new API endpoint following team conventions
---

# New API Endpoint

When creating a new REST API endpoint, follow this structure exactly.

## Files to Create

For a resource called `<resource>`:

1. **Route handler**: `packages/api/src/app/api/<resource>/route.ts`
2. **Zod schema**: `packages/api/src/schemas/<resource>.ts`
3. **Database queries**: `packages/api/src/db/queries/<resource>.ts`
4. **Integration test**: `packages/api/src/__tests__/integration/<resource>.test.ts`
5. **OpenAPI spec entry**: Add the endpoint to `docs/api.yaml`

## Route Handler Pattern

Every route handler must follow this structure:

```typescript
import { NextRequest } from "next/server";
import { withErrorHandler } from "@/middleware/error-handler";
import { withAuth } from "@/middleware/auth";
import { ApiResponse } from "@/lib/api-response";
import { createResourceSchema, updateResourceSchema } from "@/schemas/<resource>";
import { getResources, createResource, getResourceById, updateResource, deleteResource } from "@/db/queries/<resource>";

export const GET = withErrorHandler(
  withAuth(async (req: NextRequest) => {
    const resources = await getResources();
    return ApiResponse.ok(resources);
  })
);

export const POST = withErrorHandler(
  withAuth(async (req: NextRequest) => {
    const body = await req.json();
    const validated = createResourceSchema.parse(body);
    const resource = await createResource(validated);
    return ApiResponse.created(resource);
  })
);
```

Rules:
- Always wrap with `withErrorHandler` as the outermost middleware.
- Always wrap with `withAuth` for protected endpoints.
- Parse request bodies with the Zod schema — never access raw body fields directly.
- Return responses using `ApiResponse` helpers (`.ok()`, `.created()`, `.noContent()`).
- Database calls go through the query functions — never write Prisma calls in the handler.

## Schema Pattern

```typescript
import { z } from "zod";

export const createResourceSchema = z.object({
  name: z.string().min(1).max(255),
  // ... fields
});

export const updateResourceSchema = createResourceSchema.partial();

export type CreateResource = z.infer<typeof createResourceSchema>;
export type UpdateResource = z.infer<typeof updateResourceSchema>;
```

Rules:
- Export both the schema and the inferred TypeScript type.
- Update schemas should use `.partial()` on the create schema.
- Add `.min()` and `.max()` constraints for strings. Add `.int()` and `.positive()` for numeric IDs.

## Database Query Pattern

```typescript
import { prisma } from "@/lib/prisma";
import type { CreateResource, UpdateResource } from "@/schemas/<resource>";

export async function getResources() {
  return prisma.resource.findMany({ orderBy: { createdAt: "desc" } });
}

export async function getResourceById(id: string) {
  return prisma.resource.findUniqueOrThrow({ where: { id } });
}

export async function createResource(data: CreateResource) {
  return prisma.resource.create({ data });
}

export async function updateResource(id: string, data: UpdateResource) {
  return prisma.resource.update({ where: { id }, data });
}

export async function deleteResource(id: string) {
  return prisma.resource.delete({ where: { id } });
}
```

Rules:
- One function per operation. Name them `get`, `create`, `update`, `delete` + resource name.
- Use the Zod-inferred types for input parameters.
- Use `findUniqueOrThrow` for single-record lookups (throws a 404-mappable error).
- Default sort order is `createdAt: "desc"`.

## Test Pattern

```typescript
import { describe, it, expect, beforeEach } from "vitest";
import { createTestClient } from "@/test-utils";

describe("GET /api/<resource>", () => {
  const client = createTestClient();

  it("returns a list of resources", async () => {
    const res = await client.get("/api/<resource>");
    expect(res.status).toBe(200);
    expect(res.body.data).toBeInstanceOf(Array);
  });

  it("requires authentication", async () => {
    const res = await client.get("/api/<resource>", { authenticated: false });
    expect(res.status).toBe(401);
  });
});

describe("POST /api/<resource>", () => {
  const client = createTestClient();

  it("creates a resource with valid data", async () => {
    const res = await client.post("/api/<resource>", {
      body: { name: "Test Resource" },
    });
    expect(res.status).toBe(201);
    expect(res.body.data.name).toBe("Test Resource");
  });

  it("rejects invalid data", async () => {
    const res = await client.post("/api/<resource>", {
      body: { name: "" },
    });
    expect(res.status).toBe(400);
  });
});
```

Required test cases for every endpoint:
- Happy path for each HTTP method
- Authentication failure (missing/invalid token)
- Validation failure (malformed input)
- Not-found case for resource lookups by ID
