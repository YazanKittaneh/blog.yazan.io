---
name: incident
description: Guide through incident response — diagnosis, mitigation, and postmortem
---

# Incident Response

> **Adapt this skill:** Replace the URLs, channel names, and runbook steps with your team's actual incident process.

## Step 1: Declare the Incident

- Post in #incidents: "Incident declared — [brief description]. I'm investigating."
- Assign an incident commander if the issue affects multiple services
- Start a timeline document (use the template at `docs/incident-template.md`)

## Step 2: Diagnose

Check the following in order:

1. **Error rates** — Sentry dashboard for recent spikes
2. **Latency** — Vercel Analytics or your APM tool
3. **Recent deploys** — check the Vercel deployment log for anything in the last 2 hours
4. **Database** — connection pool exhaustion, slow queries, replication lag
5. **External dependencies** — check status pages for Stripe, Auth0, SendGrid, etc.

## Step 3: Mitigate

Choose the fastest path to restore service:

- **Rollback** if a recent deploy caused the issue: `git revert HEAD && git push origin main`
- **Feature flag** if the issue is isolated to a new feature
- **Scale up** if the issue is load-related
- **Disable the affected endpoint** as a last resort to protect the rest of the system

## Step 4: Communicate

- Update #incidents every 15 minutes with status
- If customers are affected, notify via your status page
- When resolved, post "Incident resolved — [brief description of fix]"

## Step 5: Postmortem

Within 48 hours of resolution:

- Write a blameless postmortem using `docs/incident-template.md`
- Identify contributing factors (not root cause — incidents are complex)
- List action items with owners and due dates
- Share in #engineering
