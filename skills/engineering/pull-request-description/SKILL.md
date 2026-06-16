---
name: pull-request-description
description: >-
  Turns a branch diff or commit list into a clear pull request description with
  summary, motivation, test plan, and breaking changes. Use when the user says
  "write a PR description", "summarize this diff for reviewers", or "generate
  a PR body".
---

# Pull Request Description Writer

## Quick start

1. Get the diff or commit list (`git diff main...HEAD` or `git log main..HEAD --oneline`).
2. Identify: what changed, why, and any risks.
3. Fill the template below. Skip sections that genuinely don't apply.

## How to gather context

```bash
# Commits on this branch
git log main..HEAD --oneline

# Full diff
git diff main...HEAD

# Files changed
git diff main...HEAD --name-status
```

Ask the user if the motivation or ticket number is not obvious from the code.

## Output template

```markdown
## Summary
<!-- 2–4 sentences. What this PR does and why. The "why" matters most. -->

## Changes
<!-- Bulleted list of the significant changes. Group by area if large. -->
- 
- 

## Test plan
<!-- How a reviewer can verify this works. Be specific — "it works" is not a test plan. -->
- [ ] 
- [ ] 

## Screenshots / recordings
<!-- Delete this section if no UI changes. -->

## Breaking changes
<!-- List any removed APIs, renamed fields, changed defaults, or migration steps.
     Delete if none. -->

## Related issues / tickets
<!-- Closes #123, Fixes #456, or N/A -->
```

## Section guidance

### Summary
- Lead with the user-facing or business impact, not the implementation.
- Bad: "Refactored auth middleware to use JWT."
- Good: "Replaces session cookies with JWT tokens so users stay logged in across devices."

### Changes
- One bullet per logical change, not per file.
- Omit trivial formatting or dependency bumps unless they're the point of the PR.

### Test plan
- Each item should be a concrete action + expected outcome.
- Include: happy path, key edge cases, regression risk areas.
- Example: `[ ] Log in with expired token → redirected to /login with error message`

### Breaking changes
Flag any of these:
- Deleted or renamed public API endpoints, functions, or types
- Changed default behaviour or config key names
- Database schema changes requiring migration
- Environment variable additions that are required (not optional)

## Quality checks before submitting

- [ ] Title is `<type>: <short imperative description>` (≤72 chars)
- [ ] Summary explains the *why*, not just the *what*
- [ ] Test plan has at least one checkable item
- [ ] Breaking changes section present if any exist
- [ ] Related issue linked

## Example

**Input:** three commits — "add rate limiting middleware", "wire middleware to /api routes", "add tests for rate limiter"

**Output:**

```markdown
## Summary
Adds per-IP rate limiting to all `/api` routes (100 req/min). Prevents
abuse and reduces load on downstream services during traffic spikes.

## Changes
- New `rateLimiter` middleware using an in-memory sliding window
- Applied to all routes under `/api/*`
- Unit tests covering limit enforcement and header values

## Test plan
- [ ] Send 101 requests in 60 s → 101st returns `429 Too Many Requests`
- [ ] Response includes `Retry-After` and `X-RateLimit-*` headers
- [ ] Routes outside `/api` are unaffected

## Breaking changes
- Clients hitting the API in tight loops will now receive `429` errors.
  Add exponential back-off on the client side.

## Related issues / tickets
Closes #87
```
