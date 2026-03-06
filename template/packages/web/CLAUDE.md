# packages/web — Frontend Package

> Supplements the root `CLAUDE.md`. These conventions apply only when working inside `packages/web/`.

## Component Rules
- One component per file, filename matches the component name
- Co-locate styles, tests, and stories with the component file
- No inline styles — use Tailwind utility classes only
- No default exports from component files

## State Management
- Server state with React Query (`src/lib/query/`)
- Local UI state with `useState` or `useReducer`
- Global app state with Zustand (`src/store/`)
- No prop-drilling beyond two levels — lift to store or use composition

## Data Fetching
- All API calls go through the typed client at `src/lib/api-client.ts`
- Never call `fetch()` directly in a component
- Loading and error states are required for every data-fetching component

## Accessibility
- Every interactive element must be keyboard-navigable
- Images require descriptive `alt` text (empty string only for decorative images)
- Use semantic HTML elements before reaching for `div`
