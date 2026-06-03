# Iran War Watch — blog series

Five posts compiled from the running analysis, in chronological order. Each is a standalone Markdown file with YAML frontmatter, written to drop into a static-site `content/`, `posts/`, or `src/content/blog/` directory.

| # | Date | Slug | Theme |
|---|------|------|-------|
| 1 | 2026-03-26 | `when-the-strait-closed` | The opening shock + 59-company economic impact |
| 2 | 2026-04-07 | `the-media-gap` | Why independent reporting led the wires by 2–3 days |
| 3 | 2026-04-27 | `scenarios-not-forecasts` | Probability weights + the empire-erosion reframe |
| 4 | 2026-05-05 | `scenario-b` | Project Freedom, Fujairah, re-escalation confirmed |
| 5 | 2026-05-25 | `the-scorecard` | Honest grading — hits, misses, the clock I misread |

## Editorial choices

- **Voice:** analytical and conversational, no self-promotion — consistent with the LinkedIn cadence (Where we are → media gap → core thesis → probability weights → what I'm watching).
- **Revision history is the point.** Each post grades the prior one. Post 5 is the keystone: it shows the misses, not just the hits. That honesty is the credibility.
- **No verbatim news copy.** Everything is synthesized from our own prior analysis; events and prices are stated as facts, not quoted from articles.
- **Personal-decision content is kept light.** The EV/job-search/Australia threads are referenced abstractly in Post 3 rather than spelled out, so the series reads as public industry analysis. Say the word if you want a separate, more personal "what I actually did about it" companion post.

## Frontmatter — read this before committing

The frontmatter is portable YAML that works as-is for Astro, Hugo, Jekyll, Eleventy, and Next.js/Contentlayer. But the exact keys differ by framework, so tell me which one `blog.yazan.io` runs and I'll do a one-pass fix. Common adjustments:

- **Astro content collections:** likely wants `pubDate` instead of `date`, and a schema-matched `description`/`tags`. Series support via a `series` field or a collection.
- **Hugo:** `date`, `description`, `tags`, `draft` all work; `series` maps to a taxonomy if you've defined one. Files usually go in `content/posts/`.
- **Jekyll:** filenames must be `YYYY-MM-DD-slug.md` (these already are) and live in `_posts/`. `date` and `tags` work; `description` maps to `excerpt` in some themes.
- **Next.js (MDX/Contentlayer):** rename `.md` → `.mdx` if you use components; `date` may need to be `publishedAt`.
