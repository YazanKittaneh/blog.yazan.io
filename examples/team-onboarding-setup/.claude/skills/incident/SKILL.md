---
name: incident
description: Guide through the incident response workflow
disable-model-invocation: true
allowed-tools:
  - Bash
  - Read
  - Grep
  - Glob
---

# Incident Response

Follow this workflow when responding to a production incident.

## Step 1: Triage

1. Identify the scope of the incident:
   - Which services are affected?
   - Is the issue user-facing?
   - When did it start?

2. Check recent deployments:
   ```bash
   git log --oneline --since="24 hours ago" --format="%h %s (%an, %ar)"
   ```

3. Check application health:
   ```bash
   curl -sf https://api.acme.com/health | jq .
   ```

4. Check error monitoring:
   ```bash
   gh api repos/acme-corp/acme-app/actions/runs --jq '.workflow_runs[:5] | .[] | "\(.status) \(.conclusion) \(.name) \(.created_at)"'
   ```

## Step 2: Assess Severity

| Severity | Criteria | Response Time |
|:---------|:---------|:-------------|
| **SEV-1** | Service down, data loss, or security breach | Immediate. All hands. |
| **SEV-2** | Major feature broken, significant user impact | Within 30 minutes. |
| **SEV-3** | Minor feature broken, workaround available | Within 4 hours. |
| **SEV-4** | Cosmetic issue, no functional impact | Next business day. |

## Step 3: Mitigate

For SEV-1 and SEV-2, prioritize mitigation over root cause analysis.

**If caused by a recent deploy**, roll back:
```bash
# Find the last known good tag
git tag --sort=-creatordate | head -5

# Deploy the previous tag
git checkout <previous-tag>
git push origin HEAD:staging  # Verify on staging first
```

**If caused by a data issue**, check recent migrations:
```bash
ls -lt packages/api/prisma/migrations/ | head -5
```

**If caused by an external dependency**, check status pages and degrade gracefully.

## Step 4: Communicate

Post an update in `#incidents` with:
- What is happening
- Who is investigating
- Current severity level
- Estimated time to resolution (if known)

Update every 30 minutes for SEV-1, every hour for SEV-2.

## Step 5: Resolve and Document

Once the incident is resolved:

1. Confirm the fix is deployed and verified:
   ```bash
   curl -sf https://api.acme.com/health | jq .
   ```

2. Post a resolution message in `#incidents`.

3. Create a post-mortem document. Include:
   - **Timeline**: When did it start, when was it detected, when was it resolved?
   - **Root cause**: What specifically went wrong?
   - **Impact**: How many users were affected and for how long?
   - **Mitigation**: What was done to stop the bleeding?
   - **Fix**: What was the permanent fix?
   - **Action items**: What changes will prevent this from recurring?

4. Schedule a blameless post-mortem meeting within 48 hours.

5. Create follow-up tickets for each action item:
   ```bash
   gh issue create --title "Post-mortem action: <description>" --label "incident-followup"
   ```
