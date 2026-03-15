# LinkedIn Posts — Ship Standards, Not Wikis

One post per week, timed with each article's publish date. Post Tuesday or Wednesday for best reach with engineering audiences.

---

## Post 0 — Series Teaser (Week of Feb 3 — before Part 1 drops)

The engineering wiki is the most expensive document in your org. Nobody reads it.

Your new developer spent their first week in Confluence.

By the time they were productive, they'd absorbed your real standards through osmosis — PR comments, Slack corrections, code review friction.

The wiki didn't fail because it wasn't written well. It failed because it's the wrong format. Documentation that lives outside the development environment will always drift.

I'm publishing a series on replacing the onboarding wiki entirely — encoding your team's standards, rituals, and guardrails directly into the tools where the code gets written.

8 parts. Starts this Friday.

Follow to catch each one as it drops.

---

## Post 1 — Why Onboarding Wikis Fail (Feb 6)

Your coding standards exist. They're just trapped in the wrong place.

New developer joins. Gets the Confluence link. Spends a week reading.

Three months later they're still learning your "real" standards — the ones that only surface in PR review comments, Slack corrections, and the occasional "that's not how we do it here."

The wiki isn't wrong. It's just not in the room when the code is being written.

There's a three-layer model for encoding standards directly into the development environment. Each layer solves a different part of the onboarding problem: one sets the context, one transfers the knowledge, one enforces the rules.

Full breakdown: [link]

---

## Post 2 — CLAUDE.md: Your Team's Constitution (Feb 13)

A new developer should know your stack before they type their first line of code.

Not after reading the wiki. Before.

Here's how: a single committed markdown file that your AI coding tool reads automatically at the start of every session.

Tech stack. Naming conventions. Testing requirements. Git workflow. The patterns that aren't obvious from the code. The rules that would get flagged in review.

The developer clones the repo, opens the tool, and — without being asked — it already knows how your team works. No setup guide. No onboarding doc. The standards are just there.

The difference between this and a wiki isn't the content. It's the timing. The developer gets the context while they're doing the work, not during onboarding week when it's too abstract to stick.

What goes in it, how monorepos handle it, and how personal overrides work: [link]

---

## Post 3 — The Plugin Marketplace (Feb 20)

"Which extensions should I install?" is a question that should not exist in 2026.

New developer setup checklists are a sign that your toolchain isn't configurable enough. Install this, configure that, ask someone in Slack for the right env var.

Claude Code has a plugin marketplace — TypeScript language server, GitHub, Linear, Sentry, Vercel, and more. You declare which plugins your project requires in a config file committed to the repo.

When a new developer clones it and opens Claude Code, they're prompted to install everything automatically. One confirmation. Environment configured.

When the team adopts a new integration, one PR updates the config and every developer gets it on their next clone.

What the config looks like and how auto-install works: [link]

---

## Post 4 — Building an Internal Marketplace (Feb 27)

The best onboarding experience is one where the tools install themselves.

The official plugin marketplace covers common integrations. But your org has its own tools — the internal deployment pipeline, the design system, the incident runbook.

You can host your own marketplace. Teams register it with one command. Your internal tools show up in the same discovery interface as the official ones.

The part that makes this worth doing: a plugin isn't just an integration. It's a bundle. One plugin can ship the connection to your CI system, the skill that walks through your deploy checklist, and the hooks that block a deploy if tests haven't passed.

The institutional knowledge travels with the tool.

How to structure an internal marketplace and what a plugin can contain: [link]

---

## Post 5 — Skills and the Deploy Ritual (Mar 6)

When was the last time your entire team deployed the exact same way?

Every team has a deploy checklist. Tests pass. Branch is up to date. No pending migrations. Release tag. Post in #releases.

In practice: people skip steps when they're in a hurry. New developers forget steps they haven't memorized yet. The checklist lives in a doc nobody opens under pressure.

Skills encode rituals as executable instructions. A developer types /deploy. The tool runs the entire checklist — tests, type check, branch check, migration scan, the deploy itself, the Slack message.

No skipped steps. No improvisation. The ritual runs the same way every time, for every developer on the team.

What the deploy skill looks like and how to build one: [link]

---

## Post 6 — Skills: Scaffolding and Auto-Activation (Mar 13)

Your senior engineers' institutional knowledge is leaving your company one commit at a time.

The way your team structures an API endpoint. The specific files to create, in the right folders, with the right patterns. The test coverage requirements. The middleware to use.

New developers learn this through friction. "That's not where we put the schema." "The handler shouldn't have direct SQL." "Where's the integration test?"

You can encode that knowledge as a skill. When a developer asks the tool to create a new API endpoint, the skill activates automatically — it scaffolds the route handler, schema, database query, and tests following the exact structure your team uses.

The senior engineer's hard-won knowledge is now baked into the tool.

How auto-activation works and where skills live across projects, plugins, and personal configs: [link]

---

## Post 7 — Hooks and Automated Guardrails (Mar 20)

"Always run the formatter before committing" is not a standard. It's a suggestion.

Standards enforced by human memory don't scale. Formatting. Secret detection. Test coverage thresholds. The linter config everyone knows about but not everyone runs.

Claude Code has hooks — shell commands that execute at specific points in the development lifecycle.

Before a file is written: a script checks for secrets. If it finds one, the write is blocked. The mistake never happens.

After a file is edited: the formatter and linter run automatically. Style comments disappear from your PRs — not because developers remember, but because it's structural.

When the tool says it's done: a hook verifies that tests actually pass before the session ends.

The guardrails aren't advisory. They're part of the environment.

All four hook types and how to scope them for a team: [link]

---

## Post 8 — The Full Picture (Mar 27)

What if day one felt like the new developer had already been on the team for a month?

They clone the repo. Open the tool. Trust the project folder.

Plugins install automatically. The tool knows the tech stack, naming conventions, and git workflow before they type a character. Sprint context loads. The environment is checked.

They ask it to create a new API endpoint. It scaffolds the exact structure the team uses. Every file is formatted as it's written. Secrets can't be committed. The deploy checklist is a slash command. When they say done, tests have to pass.

They didn't read a wiki. They didn't ask in Slack. They didn't accidentally break a convention they'd never heard of. The standards were never communicated as documentation — they were experienced as the natural behavior of the tool.

That's the last post in the series. There's also a GitHub template with everything: CLAUDE.md, four skills, hooks config, and the utility scripts. Copy what you need.

Day-one walkthrough, four-week rollout plan, and template: [link]
