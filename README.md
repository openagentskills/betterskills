# Agent Skills Catalogue

A **portable, open catalogue** of [agent skills](docs/glossary.md) for IDEs, vibe-coding tools, chatbots, and CLI assistants. Skills teach an AI agent *how* to perform a task — with checklists, templates, and domain rules — not just *what* to answer in chat.

Works across **Cursor**, **Claude Code**, **Windsurf**, **Cline**, **GitHub Copilot**, **Continue**, **Codex**, and any tool that loads markdown instructions from disk.

## Quick start

### Cursor

```bash
# Project-scoped (recommended for teams)
mkdir -p .cursor/skills
cp -r path/to/skills-catalogue/skills/engineering/code-review .cursor/skills/

# Or personal (all projects)
cp -r path/to/skills-catalogue/skills/engineering/code-review ~/.cursor/skills/
```

Invoke in chat: *"Use the code-review skill on this PR."*

### Claude Code

```bash
mkdir -p .claude/skills
cp -r skills/engineering/code-review .claude/skills/
```

### Other tools

See [docs/platforms.md](docs/platforms.md) for install paths and adapters.

## Catalogue (starter set)

| Skill | Category | Kind |
|-------|----------|------|
| [code-review](skills/engineering/code-review/) | Development | Engineering |
| [conventional-commits](skills/engineering/conventional-commits/) | Git | Engineering |
| [rest-api-design](skills/engineering/rest-api-design/) | Architecture | Engineering |
| [security-review](skills/engineering/security-review/) | Security | Engineering |
| [systematic-debugging](skills/engineering/systematic-debugging/) | Debugging | Engineering |
| [meeting-notes](skills/productivity/meeting-notes/) | Productivity | Non-engineering |
| [professional-email](skills/communication/professional-email/) | Communication | Non-engineering |
| [research-synthesis](skills/research/research-synthesis/) | Research | Non-engineering |
| [technical-writing](skills/documentation/technical-writing/) | Documentation | Hybrid |
| [spreadsheet-analysis](skills/data/spreadsheet-analysis/) | Data | Hybrid |

Full index: [`catalogue.yaml`](catalogue.yaml)

## Repository layout

```
.
├── catalogue.yaml          # Machine-readable skill index
├── schema/                 # JSON Schema for manifests & catalogue
├── docs/                   # Portability, platforms, authoring guides
├── skills/                 # Canonical skill packages
│   ├── engineering/
│   ├── productivity/
│   ├── communication/
│   ├── research/
│   ├── documentation/
│   └── data/
└── scripts/
    └── validate.sh         # Lint all skills before PR
```

Each skill is a folder:

```
skill-name/
├── skill.manifest.yaml   # Portable metadata (platforms, tags, version)
├── SKILL.md              # Required — agent instructions
└── reference.md          # Optional — deep reference
```

## Portability model

1. **Canonical format** — Every skill is plain Markdown + YAML frontmatter in `SKILL.md`.
2. **Manifest** — `skill.manifest.yaml` declares id, category, supported platforms, and install hints.
3. **No vendor lock-in** — Skills avoid tool-specific APIs unless noted in `platform-notes.md`.
4. **Copy-install today** — Symlink or copy into your tool's skills directory; future: `scripts/install.sh`.

Details: [docs/portability.md](docs/portability.md)

## Contributing

We welcome new skills, platform adapters, and translations. See [CONTRIBUTING.md](CONTRIBUTING.md).

**Want to add a skill?** Browse [open skill build issues](https://github.com/openagentskills/betterskills/issues?q=is%3Aissue+is%3Aopen+label%3Askill-request) or start from the [contributor hub](https://github.com/openagentskills/betterskills/issues/17).

```bash
./scripts/validate.sh   # run before opening a PR
```

## Roadmap

- [ ] CLI installer (`install.sh` / `npx skills-catalogue`)
- [ ] Community skill registry (GitHub Discussions or separate index repo)
- [ ] Platform-specific thin wrappers where needed
- [ ] Skill versioning and changelog per skill

## License

MIT — see [LICENSE](LICENSE).
