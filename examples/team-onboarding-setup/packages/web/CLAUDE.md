# Web Package

This package contains the customer-facing web application built with Next.js App Router.

## Architecture

- Pages live in `src/app/(routes)/` using the route group pattern.
- Shared layout components are in `src/components/layout/`.
- Feature-specific components live alongside their page in `src/app/(routes)/<page>/components/`.
- Server Components are the default. Only add `"use client"` when the component needs interactivity.

## Styling

- Tailwind CSS only. No CSS modules, no styled-components, no inline `style` props.
- Design tokens are defined in `tailwind.config.ts` under `theme.extend`.
- Use the `cn()` utility from `src/lib/utils.ts` for conditional class merging.
- Responsive breakpoints: `sm` (640px), `md` (768px), `lg` (1024px), `xl` (1280px).

## Components

- Use the internal component library in `src/components/ui/` (based on shadcn/ui patterns).
- All interactive components must be keyboard accessible.
- Form components use React Hook Form + Zod for validation.
- Loading states use Suspense boundaries with skeleton components from `src/components/ui/skeleton.tsx`.

## State Management

- Server state: React Server Components + `fetch` with Next.js caching.
- Client state: Zustand stores in `src/stores/`. One store per domain concern.
- URL state: `nuqs` for search params. Never use `useState` for URL-synced values.

## Performance

- Images use `next/image` with explicit `width` and `height`.
- Dynamic imports (`next/dynamic`) for components not needed on initial render.
- Fonts loaded via `next/font/google` — never import from a CDN.
