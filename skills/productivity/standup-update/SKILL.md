---
name: standup-update
description: >-
  Turns raw notes or bullet dumps into a concise standup update with yesterday,
  today, and blockers sections. Use when the user asks for a daily update,
  standup summary, or to summarize what they did yesterday for Slack or Teams.
---

# Standup / Daily Update Writer

## Quick start

1. Collect raw notes: commits, tickets, bullets, or voice-to-text dumps.
2. Sort items into yesterday (done), today (planned), and blockers.
3. Keep each section to 2–5 bullets; lead with outcomes, not activity.
4. Output in the template below unless the user requests a different format.

## Output template

```markdown
**Yesterday**
- [Completed outcome or deliverable]
- [Another completed item]

**Today**
- [Planned focus or next step]
- [Another planned item]

**Blockers**
- [Blocker with who/what is needed] — or "None"
```

## Writing rules

- **Yesterday** — Past tense; emphasize results ("shipped login fix") not process ("worked on login").
- **Today** — Present or future tense; one primary focus per bullet.
- **Blockers** — Be specific: dependency, decision, access, or person needed. Omit fluff.
- **Length** — Default to three sections only; skip optional sections unless asked.
- **Tone** — Direct and scannable for async channels (Slack, Teams, email).

## Optional variants

If the user asks for a shorter format:

```markdown
Done: [item 1]; [item 2]
Next: [item 1]; [item 2]
Blocked: [blocker] or None
```

If the user asks for a team-wide roll-up, group by person or squad using the same three sections.

## Example

**Input**

```
- fixed the jwt bug in staging
- pr waiting on review from alex
- need db migration approved before prod deploy
- today want to finish rate limiting middleware
- also need to prep demo for friday
```

**Output**

```markdown
**Yesterday**
- Fixed JWT validation bug in staging

**Today**
- Finish rate limiting middleware
- Prep demo for Friday

**Blockers**
- PR waiting on review from Alex
- DB migration needs approval before production deploy
```
