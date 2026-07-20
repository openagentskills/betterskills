---
name: pull-request-description
description: >-
  Generates clear, structured pull request descriptions from branch diffs or commit
  lists. Creates summaries, change logs, test plans, breaking change notes, and related
  issue references. Use when the user asks for a PR description, needs to summarize
  changes for reviewers, or wants a test plan section for their PR.
  Turns a branch diff or commit list into a clear pull request description with
  summary, motivation, test plan, and breaking changes. Use when the user says
  "write a PR description", "summarize this diff for reviewers", or "generate
  a PR body".
---

# Pull Request Description Writer

## Quick start

1. Read the branch diff (`git diff main...HEAD`) or commit list (`git log main..HEAD --oneline`).
2. Identify the type of change: feature, bug fix, refactor, performance, docs, or breaking change.
3. Apply the output template below.
4. Fill each section. If a section has no content (e.g., no breaking changes), omit it — do not write "None" or filler text.

## Workflow

- [ ] Run `git diff main...HEAD --stat` to get file change overview.
- [ ] Run `git log main..HEAD --oneline` to get commit messages.
- [ ] Categorise each commit: feat, fix, refactor, perf, docs, chore, breaking.
- [ ] Infer the **motivation** — why this change matters, not just what it does.
- [ ] Identify any **breaking changes**: API signature changes, config format changes, removed features, behavioural changes users will notice.
- [ ] If tests exist, summarise them. If not, note what manual testing was done.
- [ ] Link related issues by scanning commit messages for `#NNN` or `closes #NNN`.

## Output format

```markdown
## Summary

[1-3 sentences: what this PR does and why. Write for a reviewer who has no context.]

## Changes

- **[Category]** Brief description of change
  - Why this approach (if not obvious)

## Test plan

- [ ] Automated: [describe tests that exist or were added]
- [ ] Manual: [steps a reviewer should test, or "N/A — covered by CI"]

## Screenshots (if UI changes)

| Before | After |
|--------|-------|
| [image] | [image] |

## Breaking changes

- [List items only if there are breaking changes. Remove entire section if none.]

## Related issues

- Closes #NNN
- Related to #NNN
```

## Commit message → PR section mapping

| Commit prefix | PR section |
|---------------|------------|
| `feat:` / `add` | Changes (feature) |
| `fix:` / `bug` | Changes (bug fix) |
| `refactor:` | Changes (refactor) |
| `perf:` | Changes (performance) |
| `docs:` | Changes (documentation) |
| `chore:` | Omit from Changes unless reviewer-relevant |
| `BREAKING CHANGE:` | Breaking changes |
| `closes #NNN` | Related issues |

## Examples

**Input (messy commits):**
```
fix stuff
WIP
actually fix it this time
feat: add export to CSV
fix: handle empty result set
update readme
BREAKING CHANGE: CSV endpoint returns array instead of object
closes #42
```

**Output:**
```markdown
## Summary

Adds CSV export to the reporting API and fixes a crash when query results are empty.
The CSV endpoint response format changed — see Breaking changes.

## Changes

- **Feature** Add CSV export endpoint (`GET /api/reports/export?format=csv`)
  - Uses streaming response for large datasets
- **Bug fix** Handle empty result sets without 500 error
- **Docs** Update README with CSV export usage

## Test plan

- [x] Automated: Added `test_csv_export`, `test_csv_export_empty`, `test_csv_export_streaming`
- [ ] Manual: Verify CSV opens correctly in Excel and Google Sheets

## Breaking changes

- `GET /api/reports/export?format=csv` returns `[{...}, {...}]` (array) instead of `{"data": [{...}]}` (object with wrapper). Update any CSV parsing code to expect a top-level array.

## Related issues

- Closes #42
```

## Tips

- If commit messages are meaningless ("fix", "WIP", "."), ignore them. Describe changes by reading the diff directly.
- Keep Summary under 3 sentences. Reviewers skim; they need the point fast.
- Put the most impactful change first in the Changes list.
- For UI changes, screenshots are not optional — add `<!-- TODO: add screenshots -->` if the author hasn't provided them yet.
- If the PR touches >10 files, add a "Files changed" note at the end: `**Files:** 12 changed, +340 −120`.
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
