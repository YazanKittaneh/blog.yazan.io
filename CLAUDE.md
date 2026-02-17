# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
pnpm dev        # Start development server
pnpm build      # Production build
pnpm start      # Start production server
```

No lint or test scripts are configured.

## Architecture

Next.js 14 App Router blog with two content sections:

- **`/blog`** — long-form articles at `app/blog/posts/*.mdx`
- **`/prompt`** — curated prompts/writing at `app/prompt/posts/*.mdx`

Both sections share the same pattern: a `utils.ts` that reads `.mdx` files from the `posts/` directory at build time using Node `fs`, parses YAML frontmatter manually (no library), derives the URL slug from the filename, and exports a typed array of posts.

### MDX Rendering

`app/components/mdx.tsx` uses `next-mdx-remote/rsc` (not `@next/mdx`) with custom component overrides: heading anchor links, syntax highlighting via `sugar-high`, `next/image`, `next/link`, and a custom `<Table>` component. Pass `<Table data={{ headers, rows }} />` in MDX for styled tables.

### Content Frontmatter

Every `.mdx` post requires:

```yaml
---
title: Post Title
publishedAt: YYYY-MM-DD
summary: One-sentence description
---
```

Optional: `image` (path for OG image override).

### SEO & Metadata

- `app/sitemap.ts` exports `baseUrl` used across the app — update this when the domain changes.
- OG images are dynamically generated at `app/og/route.tsx` using the post title.
- JSON-LD schema is inlined in each blog post page.

### Styling

Tailwind v4 (alpha) with PostCSS. No `tailwind.config.js` — configuration is handled through `postcss.config.js` and `@tailwindcss/postcss`.
