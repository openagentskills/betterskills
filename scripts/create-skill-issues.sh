#!/usr/bin/env zsh
# One-off helper to seed contributor skill issues. Safe to re-run only on empty issue tracker.
set -euo pipefail

REPO="openagentskills/betterskills"

FOOTER=$(cat <<'EOF'

---

## How to contribute

1. Comment on this issue if you want to work on it (avoids duplicate PRs).
2. Read [CONTRIBUTING.md](https://github.com/openagentskills/betterskills/blob/main/CONTRIBUTING.md) and [docs/authoring.md](https://github.com/openagentskills/betterskills/blob/main/docs/authoring.md).
3. Copy [skills/_template/](https://github.com/openagentskills/betterskills/tree/main/skills/_template) into the right `skills/<domain>/` folder.
4. Register the skill in [catalogue.yaml](https://github.com/openagentskills/betterskills/blob/main/catalogue.yaml) with `maturity: draft` until reviewed.
5. Run `./scripts/validate.sh` and open a PR referencing this issue.

**Not listed here?** Open a [new skill proposal](https://github.com/openagentskills/betterskills/issues/new?template=new-skill.yml) with your idea.
EOF
)

create() {
  local title="$1"
  local labels="$2"
  local body="$3"
  gh issue create --repo "$REPO" --title "$title" --label "$labels" --body "${body}${FOOTER}"
}

# --- Engineering ---

create "[Skill] Pull request description writer" "skill-request,skill-build,good first issue,help wanted" "$(cat <<'ISSUE'
## Summary

Add a skill that turns a branch diff or commit list into a clear **pull request description**: summary, motivation, test plan, and breaking changes.

## Example triggers

- "Write a PR description for these changes"
- "Summarize this diff for reviewers"
- "Generate a test plan section for my PR"

## Suggested scope

| Field | Value |
|-------|-------|
| **Skill id** | `pull-request-description` |
| **Path** | `skills/engineering/pull-request-description/` |
| **Category** | `engineering.git` |
| **Kind** | `engineering` |

Include templates for: Summary, Changes, Test plan, Screenshots (optional), Breaking changes, Related issues.

## Acceptance criteria

- [ ] Manifest + SKILL.md with output template
- [ ] `catalogue.yaml` entry
- [ ] `./scripts/validate.sh` passes
- [ ] Example: messy commit messages → polished PR body
ISSUE
)"

create "[Skill] Accessibility (a11y) review" "skill-request,skill-build,help wanted" "$(cat <<'ISSUE'
## Summary

Add a skill for **accessibility reviews** of UI changes: WCAG-oriented checklist, keyboard/screen-reader concerns, and severity-tagged findings.

## Example triggers

- "Review this component for accessibility"
- "a11y audit this PR"
- "Check color contrast and focus order"

## Suggested scope

| Field | Value |
|-------|-------|
| **Skill id** | `accessibility-review` |
| **Path** | `skills/engineering/accessibility-review/` |
| **Category** | `engineering.development` |
| **Kind** | `engineering` |

Cover: semantic HTML, ARIA misuse, focus management, contrast, motion, forms/errors. Align tone with existing [code-review](https://github.com/openagentskills/betterskills/tree/main/skills/engineering/code-review) skill.

## Acceptance criteria

- [ ] Checklist + severity labels (blocker / major / minor / nit)
- [ ] `catalogue.yaml` + validate script
- [ ] At least one UI snippet example with sample findings
ISSUE
)"

create "[Skill] Test plan author" "skill-request,skill-build,good first issue,help wanted" "$(cat <<'ISSUE'
## Summary

Add a skill that produces a **structured test plan** from requirements or a PR diff: happy path, edge cases, regression, and manual vs automated notes.

## Example triggers

- "Write a test plan for this feature"
- "What should QA verify before release?"
- "List edge cases for this API change"

## Suggested scope

| Field | Value |
|-------|-------|
| **Skill id** | `test-plan-author` |
| **Path** | `skills/engineering/test-plan-author/` |
| **Category** | `engineering.development` |
| **Kind** | `engineering` |

## Acceptance criteria

- [ ] Table or checklist output format
- [ ] `catalogue.yaml` entry, validation passes
- [ ] Example for a small feature (e.g. login form or REST endpoint)
ISSUE
)"

create "[Skill] Database schema change review" "skill-request,skill-build,help wanted" "$(cat <<'ISSUE'
## Summary

Add a skill to review **database migrations and schema changes**: backwards compatibility, indexing, locking, rollbacks, and data safety.

## Example triggers

- "Review this SQL migration"
- "Is this schema change safe to deploy?"
- "Check my Flyway/Liquibase migration"

## Suggested scope

| Field | Value |
|-------|-------|
| **Skill id** | `database-schema-review` |
| **Path** | `skills/engineering/database-schema-review/` |
| **Category** | `engineering.architecture` |
| **Kind** | `engineering` |

Cover: additive vs destructive changes, index strategy, nullable columns, FK constraints, zero-downtime patterns (high level).

## Acceptance criteria

- [ ] Review checklist + risk summary template
- [ ] Registered in catalogue, validate.sh passes
- [ ] Example migration with annotated review
ISSUE
)"

create "[Skill] Infrastructure-as-code review" "skill-request,skill-build,help wanted" "$(cat <<'ISSUE'
## Summary

Add a skill for reviewing **Terraform / OpenTofu / CloudFormation** (pick one primary, note others): security, cost, naming, state, and blast radius.

## Example triggers

- "Review this Terraform module"
- "Security check my IaC PR"
- "Terraform plan review checklist"

## Suggested scope

| Field | Value |
|-------|-------|
| **Skill id** | `iac-review` |
| **Path** | `skills/engineering/iac-review/` |
| **Category** | `engineering.security` or `engineering.architecture` |
| **Kind** | `engineering` |

## Acceptance criteria

- [ ] Tool-agnostic principles + optional Terraform-specific section in `reference.md`
- [ ] Severity-tagged findings format
- [ ] catalogue.yaml + validation
ISSUE
)"

create "[Skill] CI pipeline troubleshooting" "skill-request,skill-build,help wanted" "$(cat <<'ISSUE'
## Summary

Add a skill for **debugging failing CI/CD pipelines** (GitHub Actions, GitLab CI, etc.): classify failure, isolate flaky vs real, suggest fixes, and document next steps.

## Example triggers

- "Why did my GitHub Action fail?"
- "Debug this CI log"
- "My tests pass locally but fail in CI"

## Suggested scope

| Field | Value |
|-------|-------|
| **Skill id** | `ci-pipeline-troubleshooting` |
| **Path** | `skills/engineering/ci-pipeline-troubleshooting/` |
| **Category** | `engineering.debugging` |
| **Kind** | `engineering` |

## Acceptance criteria

- [ ] Stepwise workflow (reproduce → classify → fix → prevent)
- [ ] catalogue.yaml + validate.sh
- [ ] Example with anonymized log excerpt
ISSUE
)"

# --- Productivity ---

create "[Skill] Standup / daily update writer" "skill-request,skill-build,good first issue,help wanted" "$(cat <<'ISSUE'
## Summary

Add a skill that turns raw notes into a concise **standup update**: yesterday, today, blockers — suitable for Slack or Teams.

## Example triggers

- "Write my standup from these bullets"
- "Daily update for the team"
- "Summarize what I did yesterday"

## Suggested scope

| Field | Value |
|-------|-------|
| **Skill id** | `standup-update` |
| **Path** | `skills/productivity/standup-update/` |
| **Category** | `productivity` |
| **Kind** | `non-engineering` |

Pair well with existing [meeting-notes](https://github.com/openagentskills/betterskills/tree/main/skills/productivity/meeting-notes) skill.

## Acceptance criteria

- [ ] Short template (3 sections max by default)
- [ ] catalogue.yaml + validation
- [ ] Example input bullets → standup output
ISSUE
)"

create "[Skill] Sprint retrospective facilitator" "skill-request,skill-build,help wanted" "$(cat <<'ISSUE'
## Summary

Add a skill to structure **sprint retrospectives**: Went well / Didn't go well / Actions, with optional dot-voting and facilitator prompts.

## Example triggers

- "Facilitate a retro for our sprint"
- "Retro template from these notes"
- "Turn feedback into action items"

## Suggested scope

| Field | Value |
|-------|-------|
| **Skill id** | `sprint-retrospective` |
| **Path** | `skills/productivity/sprint-retrospective/` |
| **Category** | `productivity` |
| **Kind** | `non-engineering` |

## Acceptance criteria

- [ ] Facilitator checklist + output template
- [ ] catalogue.yaml + validate.sh
- [ ] Example retro notes → structured summary
ISSUE
)"

# --- Communication ---

create "[Skill] Executive summary writer" "skill-request,skill-build,good first issue,help wanted" "$(cat <<'ISSUE'
## Summary

Add a skill that condenses long documents or threads into a **one-page executive summary**: decision needed, context, options, recommendation, risks.

## Example triggers

- "Executive summary of this report"
- "TL;DR for leadership"
- "One-pager for my VP"

## Suggested scope

| Field | Value |
|-------|-------|
| **Skill id** | `executive-summary` |
| **Path** | `skills/communication/executive-summary/` |
| **Category** | `communication` |
| **Kind** | `non-engineering` |

## Acceptance criteria

- [ ] Fixed section headings and length guidance (e.g. &lt; 400 words)
- [ ] catalogue.yaml + validation
- [ ] Example: long input → exec summary
ISSUE
)"

create "[Skill] Stakeholder status update" "skill-request,skill-build,help wanted" "$(cat <<'ISSUE'
## Summary

Add a skill for **project status updates** to stakeholders: RAG status, milestones, risks, asks — professional and scannable.

## Example triggers

- "Weekly status email for stakeholders"
- "Project health update"
- "RAG report for steering committee"

## Suggested scope

| Field | Value |
|-------|-------|
| **Skill id** | `stakeholder-status-update` |
| **Path** | `skills/communication/stakeholder-status-update/` |
| **Category** | `communication` |
| **Kind** | `non-engineering` |

## Acceptance criteria

- [ ] Template with RAG + milestones + risks + decisions needed
- [ ] catalogue.yaml + validate.sh
- [ ] One complete example
ISSUE
)"

# --- Research ---

create "[Skill] Competitive analysis brief" "skill-request,skill-build,help wanted" "$(cat <<'ISSUE'
## Summary

Add a skill to produce a **competitive analysis brief**: competitors, positioning, strengths/weaknesses, and implications — from notes or public sources (no fabricated facts).

## Example triggers

- "Compare us to competitors X and Y"
- "Competitive landscape for this product"
- "Vendor comparison table"

## Suggested scope

| Field | Value |
|-------|-------|
| **Skill id** | `competitive-analysis` |
| **Path** | `skills/research/competitive-analysis/` |
| **Category** | `research` |
| **Kind** | `non-engineering` |

Include guidance: cite sources, flag uncertainty, avoid inventing pricing/features.

## Acceptance criteria

- [ ] Output template + research hygiene rules
- [ ] catalogue.yaml + validation
- [ ] Example with placeholder competitors
ISSUE
)"

# --- Documentation ---

create "[Skill] Architecture Decision Record (ADR) author" "skill-request,skill-build,help wanted" "$(cat <<'ISSUE'
## Summary

Add a skill to draft **Architecture Decision Records** (context, decision, consequences, alternatives) in a standard format (e.g. MADR or Nygard).

## Example triggers

- "Write an ADR for choosing PostgreSQL"
- "Document this architecture decision"
- "ADR template for our team"

## Suggested scope

| Field | Value |
|-------|-------|
| **Skill id** | `adr-author` |
| **Path** | `skills/documentation/adr-author/` |
| **Category** | `documentation` |
| **Kind** | `hybrid` |

## Acceptance criteria

- [ ] ADR template + when-to-write guidance
- [ ] catalogue.yaml + validate.sh
- [ ] Example ADR for a fictional decision
ISSUE
)"

create "[Skill] README / project docs author" "skill-request,skill-build,good first issue,help wanted" "$(cat <<'ISSUE'
## Summary

Add a skill to write or improve **README files**: quick start, install, usage, contributing, license — tailored to repo type (library, app, skill catalogue).

## Example triggers

- "Write a README for this repo"
- "Improve my project documentation"
- "Add quick start section"

## Suggested scope

| Field | Value |
|-------|-------|
| **Skill id** | `readme-author` |
| **Path** | `skills/documentation/readme-author/` |
| **Category** | `documentation` |
| **Kind** | `hybrid` |

## Acceptance criteria

- [ ] Section checklist + tone guide (concise, skimmable)
- [ ] catalogue.yaml + validation
- [ ] Before/after example for a minimal repo
ISSUE
)"

# --- Data ---

create "[Skill] Metrics & dashboard spec writer" "skill-request,skill-build,help wanted" "$(cat <<'ISSUE'
## Summary

Add a skill to define **metrics and dashboard specs**: questions to answer, metrics, dimensions, charts, and data caveats — before building in Looker, Grafana, etc.

## Example triggers

- "Spec a dashboard for signup funnel"
- "What metrics should we track for retention?"
- "Dashboard requirements document"

## Suggested scope

| Field | Value |
|-------|-------|
| **Skill id** | `metrics-dashboard-spec` |
| **Path** | `skills/data/metrics-dashboard-spec/` |
| **Category** | `data` |
| **Kind** | `hybrid` |

Complements [spreadsheet-analysis](https://github.com/openagentskills/betterskills/tree/main/skills/data/spreadsheet-analysis).

## Acceptance criteria

- [ ] Spec template (goal, metrics, viz, filters, caveats)
- [ ] catalogue.yaml + validate.sh
- [ ] Example spec for one product question
ISSUE
)"

create "[Skill] SQL query review & optimization" "skill-request,skill-build,help wanted" "$(cat <<'ISSUE'
## Summary

Add a skill to **review and improve SQL queries**: readability, correctness hints, index usage, N+1 patterns, and explain-plan interpretation (conceptual).

## Example triggers

- "Optimize this SQL query"
- "Review my query for performance"
- "Explain this slow query"

## Suggested scope

| Field | Value |
|-------|-------|
| **Skill id** | `sql-query-review` |
| **Path** | `skills/data/sql-query-review/` |
| **Category** | `data` |
| **Kind** | `engineering` |

## Acceptance criteria

- [ ] Review checklist + suggested rewrite format
- [ ] catalogue.yaml + validation
- [ ] Example query with before/after commentary
ISSUE
)"

echo "Done creating skill issues."
