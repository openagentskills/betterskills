---
name: metrics-dashboard-spec
description: >-
  Produces a structured metrics and dashboard specification: questions to
  answer, KPIs, dimensions, chart types, filters, and data caveats — before
  building in Looker, Grafana, Tableau, or any BI tool. Use for dashboard
  requirements, metric definition, KPI planning, or "what should we track"
  questions.
---

# Metrics & Dashboard Spec Writer

## Workflow

1. **Clarify goal** — confirm the business question and primary audience
2. **Define metrics** — name, formula, owner, update cadence
3. **Choose dimensions** — how metrics are sliced (time, segment, region, …)
4. **Map visualizations** — pick chart types that match the question
5. **List filters** — global and per-chart controls
6. **Document caveats** — data gaps, known skew, sampling, SLA

## Spec template

```markdown
## Dashboard spec: <title>

### Goal
One sentence: what decision does this dashboard support?
Audience: <team / role>

### Questions to answer
1. …
2. …

### Metrics
| Metric | Definition | Owner | Cadence |
|--------|-----------|-------|---------|
| Name   | formula / source | team | daily / weekly |

### Dimensions (slices)
| Dimension | Values / cardinality | Notes |
|-----------|----------------------|-------|

### Visualizations
| Panel title | Chart type | X-axis | Y-axis / measure | Filters |
|-------------|-----------|--------|------------------|---------|

### Global filters
- Date range (default: last 30 days)
- …

### Data caveats
- …

### Out of scope
- …
```

## Metric definition rules

- Write formulas explicitly: `Conversion rate = signups / unique visitors × 100`
- State the grain (per user, per session, per day)
- Name the source table or event
- Flag leading vs lagging indicators

## Visualization guide

| Question type | Recommended chart |
|---------------|-------------------|
| Trend over time | Line |
| Compare categories | Bar (horizontal if >5 labels) |
| Part-to-whole | Stacked bar or pie (≤5 slices) |
| Distribution | Histogram or box plot |
| Correlation | Scatter |
| Single KPI | Stat / scorecard tile |
| Funnel steps | Funnel or waterfall |

## Caveat checklist

- [ ] Known data gaps or null windows
- [ ] Sampling or approximation in source
- [ ] Timezone handling
- [ ] Bot / internal traffic exclusions
- [ ] Metric SLA (how fresh is fresh enough?)

## Example

**User:** Spec a dashboard for the signup funnel

**Output:**

```markdown
## Dashboard spec: Signup Funnel

### Goal
Understand where prospective users drop off between landing page and
activated account so Growth can prioritise experiments.
Audience: Growth team, weekly review

### Questions to answer
1. What is the overall landing-page → activation conversion rate this week vs last week?
2. Which funnel step has the highest drop-off?
3. How does conversion vary by acquisition channel and device type?

### Metrics
| Metric | Definition | Owner | Cadence |
|--------|-----------|-------|---------|
| Landing visits | COUNT(DISTINCT session_id) WHERE page = 'landing' | Data | Daily |
| Signups started | COUNT(DISTINCT user_id) WHERE event = 'signup_start' | Data | Daily |
| Email verified | COUNT(DISTINCT user_id) WHERE event = 'email_verified' | Data | Daily |
| Activated users | COUNT(DISTINCT user_id) WHERE event = 'activation_complete' | Data | Daily |
| Funnel conversion | activated / landing visits × 100 | Data | Daily |

### Dimensions (slices)
| Dimension | Values / cardinality | Notes |
|-----------|----------------------|-------|
| Acquisition channel | organic, paid, referral, direct | utm_source |
| Device type | desktop, mobile, tablet | ~3 values |
| Date (day/week) | rolling 90 days | |

### Visualizations
| Panel title | Chart type | X-axis | Y-axis / measure | Filters |
|-------------|-----------|--------|------------------|---------|
| Weekly conversion trend | Line | Week | Funnel conversion % | Channel |
| Funnel drop-off | Funnel | Step | Users at each step | Date range |
| Step-by-step breakdown | Bar | Funnel step | Drop-off % | Channel, device |
| Channel comparison | Bar | Channel | Conversion rate | Date range |

### Global filters
- Date range (default: last 30 days)
- Acquisition channel (multi-select)

### Data caveats
- Bot sessions are excluded via `is_bot = false`; filter was added 2024-03-01 — data before that date is not comparable
- Email verified events have ~2 h ingestion lag; today's numbers update at 02:00 UTC
- Mobile Safari blocks some utm params — channel attribution undercounts ~8 % of mobile traffic

### Out of scope
- Revenue or paid conversion metrics (owned by Finance dashboard)
- Individual user drill-through (PII policy)
```
