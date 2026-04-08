# Agent Instructions

This file provides context, conventions, and instructions for AI agents operating in this repository. It follows the [AGENTS.md](https://agents.md/) standard.

## Project Context

This repository publishes the **Dev Container Specification** as a GitBook-based documentation website. It does not contain application source code; its primary content is Markdown specification documents and JSON schema files.

- **Purpose:** Maintain and publish the Dev Container specification as a GitBook site.
- **Tech stack:** GitBook (Git Sync), Markdown, JSON Schema, [just](https://just.systems/) task runner.
- **Upstream sync:** Specification files under `docs/specification/` and `docs/schemas/` are synchronized from the upstream repository [`devcontainers/spec`](https://github.com/devcontainers/spec) via the `sync-spec` just recipe. Do **not** hand-edit those files; submit changes upstream instead.

## Repository Structure

```text
/
├── docs/
│   ├── SUMMARY.md              # GitBook table of contents (controls site navigation)
│   ├── schemas/                # JSON Schema files (synced from upstream)
│   └── specification/          # Specification Markdown files (synced from upstream)
├── justfile                    # Task runner recipes (e.g., sync-spec)
├── LICENSE
└── README.md
```

## GitBook Site Structure

The site navigation is defined in `docs/SUMMARY.md`. The chapters and their content types are:

| Chapter | Content type |
|---|---|
| **Overview** | High-level introduction to the Dev Container concept |
| **Core Specification** | Normative reference for the container spec, `devcontainer.json` metadata, and supporting tools/services |
| **Features** | Specification for the Features extension system: authoring, distribution, dependencies, lifecycle hooks, environment variables, and deprecation rules |
| **Templates** | Specification for reusable Dev Container Templates: authoring and distribution/discovery |
| **Advanced Topics** | Supplementary spec pages covering image metadata, the `$devcontainerId` variable, lockfiles, parallel lifecycle script execution, and GPU host requirements |
| **Security** | Specification pages for secrets support and declarative secrets handling |
| **Schemas** | Raw JSON Schema files for `devcontainer.json`, its base schema, and the Feature schema |

## Development Workflow

Synchronize specification files from the upstream repo:

```bash
just sync-spec
```

No build step is required locally; GitBook renders the site from the Markdown files on push.

## Code Style & Conventions

- **Language preference:** Use **English** for all content — specification text, comments, commit messages, and any scripts or configuration files.
- **Markdown style:** Follow the existing formatting in `docs/specification/specs/`. Prefer ATX headings (`#`), fenced code blocks with explicit language identifiers, and reference-style links for long URLs.
- **SUMMARY.md:** Keep `docs/SUMMARY.md` in sync with the files present under `docs/`. Every Markdown file intended to appear on the site must be listed here.
- **Schema files:** These are JSON; maintain valid JSON and preserve existing key ordering conventions.

## Git & PR Guidelines

- **Commit messages:** Follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) **without a scope**:
  ```
  <type>: <short imperative description>
  ```
  Examples:
  ```
  docs: add declarative secrets specification page
  chore: sync spec files from upstream
  fix: correct broken link in features reference
  ```
  Valid types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`.
- **Do not** include a scope (e.g., avoid `docs(features): ...`).
- Title must be ≤ 50 characters; body lines wrapped at 72 characters.
