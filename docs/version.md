# Arctyk ITSM Versioning Guide

This document defines how versions are assigned and advanced across the lifecycle of **Arctyk ITSM**.
We follow **[Semantic Versioning 2.0.0](https://semver.org/)** with added stage suffixes to indicate stability.

---

## Current baseline

`v0.3.0-dev.0`

---

## Version Format

- **MAJOR** – Breaking changes or major architecture shifts  
- **MINOR** – New features added in a backward-compatible way  
- **PATCH** – Bug fixes or maintenance releases  
- **TAG** – Optional stability tag: `dev`, `alpha`, `beta`, or `rc`  
- **NUMBER** – Incremental build or iteration number (e.g., `-dev.2`)

**Example:**  
`0.3.0-dev.0`


---

## Stability Tags

| Tag | Meaning | Usage |
|-----|----------|-------|
| **-dev** | In-development, unstable internal builds | Active daily development |
| **-alpha** | Experimental snapshot, new features under test | Early external preview |
| **-beta** | Feature-complete, needs testing & feedback | Pre-release stabilization |
| **-rc** | Release candidate, pending final QA | Near-final validation |
| *(none)* | Stable release | Production-ready version |

---

## Version Roadmap

| Phase | Range | Stage | Focus |
|-------|--------|--------|--------|
| **v0.3.x** | Development | Core stabilization | Fix timezone consistency, Celery integration, recurring tickets, and asset management polish |
| **v0.4.x** | Alpha | Feature expansion | Modular app design, changelog app, import/export, CI/CD integration |
| **v0.5.x** | Beta | Integration testing | Role-based access, unit & integration tests, API documentation |
| **v0.6.x** | Beta | UX/UI refinement | Bootstrap polish, admin cleanup, user documentation |
| **v0.7.x** | RC | Release Candidate | Final testing, performance tuning, migration stability |
| **v1.0.0** | Stable | Production Release | First production-ready build of Arctyk ITSM |
| **v1.1+** | Post-release | Incremental improvements | Analytics, integrations, and new modules |

---

## Example Progression

- v0.3.0-dev.0 → Initial development baseline  
- v0.3.1-dev.1 → Minor fixes
- v0.4.0-alpha.0 → Begin modularization phase
- v0.5.0-beta.0 → Begin stabilization and testing
- v0.7.0-rc.0 → Release candidate for 1.0
- v1.0.0 → Stable production release


---

## Automation (Optional)

We use **bumpver** or **semantic-release** for automated version management. The automation is added to our `pyproject.toml` located in the project root.

**Example `pyproject.toml`:**

```toml
[tool.bumpver]
current_version = "0.3.0-dev.0"
version_pattern = "MAJOR.MINOR.PATCH[-TAG.NUMBER]"
commit_message = "chore: bump version to {new_version}"
tag_message = "Release {new_version}"
```

## Notes

- Keep all changelog entries under `CHANGELOG.md`    
- Each tagged release should include migration notes and upgrade guidance    
- Avoid skipping version numbers—increment meaningfully based on work completed
