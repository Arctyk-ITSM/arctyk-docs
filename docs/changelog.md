# Changelog

## [v0.7.0-alpha.0] - 2025-10-02

### Added
- `entrypoint.sh` automates the Docker image runtime setup
- Default user bootstrap:
    - `superuser ` created automatically from `.env` variables
    - `admin` user created automatically and added to **Admins** group
- Default role creation (Admins, Agents, Managers, End Users)
- Environment based start-up
    - configuratable from `.env`

### Changed
- `Dockerfile` refactored for multi-stage build to keep runtime image smaller, faster and with less vulnderabilities:
    - Stage 1 (builder)
        - installs Node
        - installs compiliers
        - installs Python deps
        - builds CSS
    - Stage 2 (runtime) 
        - Only includes what's needed to run Django
- `entrypoint.sh` used for run time setup:
    - Run migrations
    - Collect static
    - Create superuser if missing
    - Start Gunicorn (ASGI mode)
    - Or run Celery (worker service)
- `docker-compose.yml` refactored for orchestration:
    - define services *(db, redis, worker, etc.)*
    - does not handle app logic
- `.dockerignore` added refinements to make it tighter and safer


## v0.6.0-alpha.2

### Added
- Create Docker contaier
    - docker-compose.yml  // production
    - docker-compose-override.yml  // development 
    - added .dockerignore
- config/management/commands/create_superuser.py
    - create_superuser.py will create a super user only if one does not already exist
- .env to map security keys, database connection details and create superuser credentials
- added debug toolbar
- added whitenoise middleware to serve static files in production
- added ticket imports
- cleaned up tickets UI/UX

## v0.6.0-alpha.1

### Added
- Zendesk/Jira-style list presets: /tickets/assigned/, /tickets/mine/, /tickets/new/, priority/due filters.
- Saved Views (create/apply/delete), shared views (staff).
- Bulk quick actions: archive/restore/assign-to-me/set-status.
- CSV export honoring current filters.

### Changed
- Tickets templates moved to app path: src/tickets/templates/tickets/.
- Unified list view & sorting/pagination helpers.

### Migration
- Run `manage.py migrate` (adds TicketSavedView).

### Deprecations
- Legacy list/archived-by-tag URLs kept for now; slated for removal in a future major.`

## v0.5.0-alpha.2

## Tickets App
- Refactored models.py
    - Created new model to handle ticket views
    - Added Saved Views (user + team-shared, URL-param based)
    - Added Bulk quick actions (Archive/Restore, Assign to me, Set Status)
- Refactored views.py
    - Created a base ticket view which can be used to generate new ticket views
    - Converted function-based views to class-based views
- Refactored urls.py
    - Saved Views, Bulk quick actions, CSV export
    - fixed the duplicate archived/ route (keeps the CBV at archived/, moves the legacy tag-based list to archived-tag/)
    - set canonical CRUD names (detail, create, edit, delete) to match updated views/templates
- Refactored admin.py
- Added Saved Views which allows agents/admins to bookmark complex filters and share them with the team
- Added Bulk quick actions to provide common operations right above the list (Archive/Restore/Assign/Set Status)
- Added CSV Export to deliver the current filtered/sorted set (good for reporting)

## v0.5.0-alpha.1

### Core App
- Rafactored static files to improve bootstrap, SCSS/CSS generation

### Ticket App updates
- Added Category to ticket_detail.html

## v0.5.0-alpha.0

### Ticket App Updates
- Overdue tickets are now identified in ticket list table
    - Will identify tickets by adding an Overdue tag in the Due Date column
    - If ticket is solved or closed, the ticket will not be tagged
- Fixed Bulk Edit tickets
- Added bulk archive tickets
    - Created tickets/archived_list.html
    - Updated tickets/views.py
- Added bulk restore tickets
- Fixed Page length selection
- Fixed search and filters
- Change Meta options on ticket
    - Alter field category on ticket
    - Alter field status on ticket
- Refactored tickets/models.py
    - Corrected due date restriction to allow past dates
- Refactored tickets/views.py
    - updated ticket list views
        - Added classed-based views (CBV)
        - Updated existing function-based views (FBV) 