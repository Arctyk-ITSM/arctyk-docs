# Contributing to Arctyk ITSM

Thank you for your interest in contributing to **Arctyk ITSM**!  

We welcome all contributions, whether it’s code, documentation, design, or ideas. This guide will help you get started.

---

## Table of Contents
1. [How to Get Involved](#-how-to-get-involved)
2. [Discussions](#-discussions)
3. [Issues](#-issues)
4. [Code Contributions](#-code-contributions)
5. [Development Setup](#-development-setup)
6. [Coding Standards](#-coding-standards)
7. [Pull Requests](#-pull-requests)
8. [Community Guidelines](#-community-guidelines)

---

## How to Get Involved
There are many ways to contribute:
- Participate in [GitHub Discussions](https://github.com/orgs/Arctyk-ITSM/discussions).
- Report bugs and request features via [Issues](https://github.com/Arctyk-ITSM/arctyk-itsm/issues).
- Contribute code, docs, or tests with pull requests.
- Share your use cases and feedback to guide our roadmap.

---

## Discussions
Use [Discussions](https://github.com/orgs/Arctyk-ITSM/discussions) for:
- Asking questions
- Brainstorming new features
- Reviewing the roadmap
- Connecting with other users and contributors

---

## Issues
- Search existing issues before creating a new one.  
- For bugs, include:
  - Steps to reproduce
  - Expected behavior
  - Actual behavior
  - Environment (OS, Python/Django version, etc.)
  - For feature requests, describe the problem and the proposed solution.

---

## Code Contributions
We follow a modular approach:
- **arctyk-itsm** → full ITSM platform  
- **arctyk-tickets** → core tickets module  
- Future apps (inventory, reports, etc.) will live in their own repos  

Contribute code to the relevant app repo, not the community repo.

---

## Development Setup
1. Fork the repo you want to contribute to (e.g., `arctyk-itsm` or `arctyk-docs`).
2. Clone your fork locally:
   ```bash
   git clone git@github.com:your-username/arctyk-itsm.git
   cd arctyk-itsm
    ```
3. Create a virtual environment:

    ```bash
    py -m venv .venv
    .\.venv\Scripts\activate
    ```
4. Install dependencies:
    ```bash
    pip install -r requirements.txt
    ```
5. Run tests:
    ```bash
    pytest
    ```
## Coding Standards
- **Python:** [PEP8](https://peps.python.org/pep-0008/)
- **Linting & Formatting:** enforced via [pre-commit](https://pre-commit.com/) (`black`, `flake8`, `autoflake`)
- **Commits:** use [Convential Commits](https://www.conventionalcommits.org/)
    - `feat: add ticket assignment`
    - `fix: resolve migration conflict`
    - `chore: update dependencies`

Install pre-commit hooks directly:

```bash
pip install pre-commit
pre-commit install
```

## Pull Requests
1. Create a feature branch:
    ```bash
    git checkout -b feature/my-new-feature
    ```
2. Commit your changes with a clear message:
    ```bash
    git commit -m "feat: add bulk ticket assignment"
    ```
3. Push to your fork:
    ```bash
    git push origin feature/my-new-feature
    ```
4. Open a Pull Request against the `dev` brach of the repo.
5. Ensure:
    - All tests pass
    - Pre-commit hooks pass
    - PR description explains *why* the change is neeeded

## Community Guidelines
We follow the [Contributor Covenant](https://www.contributor-covenant.org/) Code of Conduct.

Be respectful, inclusive and collaborative.

## Questions?
Join the conversation in Discusssions or open an Issue in the relevant repo.
We're excited to build Arctyk ITSM together!

