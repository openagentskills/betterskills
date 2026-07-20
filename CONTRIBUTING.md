# Contributing to the Skills Catalogue

Thank you for helping grow a portable library of agent skills. This guide keeps contributions consistent and easy to review.

## Ways to contribute

- **New skill** — A focused workflow not already in `catalogue.yaml`
- **Improve existing skill** — Clearer steps, better examples, fixed triggers
- **Platform notes** — Install steps for a new IDE or chatbot in `docs/platforms.md`
- **Translations** — Optional `locales/<lang>/SKILL.md` alongside English `SKILL.md`
- **Tooling** — Validation, installers, CI

## Before you start

1. Search [catalogue.yaml](catalogue.yaml) and open issues — avoid duplicates.
2. Read [docs/authoring.md](docs/authoring.md) and [docs/portability.md](docs/portability.md).
3. Pick a category from `catalogue.yaml` or propose a new one in your PR description.

## Adding a new skill

### 1. Create the folder

```text
skills/<domain>/<skill-id>/
├── skill.manifest.yaml
├── SKILL.md
└── reference.md          # optional
```

Use lowercase hyphenated `skill-id` (max 64 chars). Match `name` in frontmatter.

### 2. Write `skill.manifest.yaml`

Copy from an existing skill and update:

- `id`, `version`, `category`, `kind` (`engineering` | `non-engineering` | `hybrid`)
- `tags` for discovery
- `platforms` install paths (see [docs/platforms.md](docs/platforms.md))

### 3. Write `SKILL.md`

Required YAML frontmatter:

```yaml
---
name: your-skill-id
description: >-
  Third-person description of WHAT it does and WHEN to use it.
  Include trigger terms users might say in chat.
---
```

Guidelines:

- Keep `SKILL.md` under **500 lines**; move depth to `reference.md`.
- Write `description` in **third person** with **WHAT + WHEN**.
- Prefer checklists, templates, and examples over long prose.
- Avoid time-sensitive URLs; link to stable docs.
- Default `disable-model-invocation: true` unless the skill should auto-load from context.

### 4. Register in `catalogue.yaml`

Add an entry under `skills:` with `id`, `path`, `category`, `kind`, and `maturity` (`draft` | `stable` | `deprecated`).

### 5. Validate

```bash
./scripts/validate.sh
```

### 6. Open a pull request

Use the PR template. Include:

- What problem the skill solves
- Example user prompt that should trigger it
- Which platforms you tested (if any)

## Review criteria

Maintainers look for:

| Criterion | Expectation |
|-----------|-------------|
| Scope | One clear job; split if it does two unrelated things |
| Portability | No hard dependency on a single vendor unless documented |
| Safety | No secrets, license violations, or harmful instructions |
| Size | Concise `SKILL.md`; progressive disclosure for details |
| Triggers | Description makes auto-discovery possible |

## Code of conduct

Be respectful in issues and reviews. Harassment and spam are not tolerated.

## Questions

Open a [GitHub issue](https://github.com/openagentskills/betterskills/issues) (see the [contributor hub](https://github.com/openagentskills/betterskills/issues/17) or [propose a new skill](https://github.com/openagentskills/betterskills/issues/new?template=new-skill.yml)) for skill ideas before large PRs.
