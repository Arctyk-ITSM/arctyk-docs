# Welcome to Arctyk Docs

For full documentation visit [mkdocs.org](https://www.mkdocs.org).

## Commands

* `mkdocs new [dir-name]` - Create a new project.
* `mkdocs serve` - Start the live-reloading docs server.
* `mkdocs build` - Build the documentation site.
* `mkdocs -h` - Print help message and exit.

## Project layout
This is the current project layout with Docker. 

```bash
arctyk/
├── docker/                     # Docker-related files
│   ├── web.Dockerfile          # Django + Gunicorn container
│   └── db.Dockerfile           # (optional) custom Postgres container
├── docker-compose.yml          # Compose setup for services
├── .env                        # Environment variables (not committed)
├── requirements.txt            # Python dependencies
├── STATIC_SRC/                 # SCSS/JS assets
│   ├── scss/
│   └── css/
├── src/                        # Django source
│   ├── manage.py
│   ├── helpdesk/               # Main Django project (settings, asgi, wsgi)
│   ├── tickets/                # Ticketing app
│   ├── users/                  # User management app
│   ├── projects/               # Project tracking app
│   ├── inventory/              # Asset inventory app
│   └── reports/                # Reporting app
├── media/                      # Uploaded files (mounted in container)
└── static/                     # Collected static files (mounted in container)
```

This is the project documentation layout:

```bash
    mkdocs.yml    # The configuration file.
    docs/
    ├── index.md
    ├── getting-started/
    │    ├── installation.md
    │    ├── configuration.md
    │    └── deployment.md
    ├── user-guide/
    │    ├── tickets.md
    │    ├── assets.md
    │    ├── reports.md
    ├── developer-guide/
    │    ├── architecture.md
    │    ├── api-reference.md
    │    ├── contributing.md
    │    ├── testing.md
    │    └── changelog.md
    ├── design/
    │    ├── ui-components.md
    │    └── branding.md
    └── integrations/
        ├── jira.md
        ├── zendesk.md
        └── power-platform.md
```