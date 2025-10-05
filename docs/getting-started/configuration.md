# Configuration
After installing Arctyk ITSM using Docker, you’ll need to configure environment variables, database connections, and optional integrations before launching it in production.

This guide walks you through customizing your `.env`, adjusting `docker-compose.yml`, and verifying that all services are connected properly.


## Environment Variables
Arctyk ITSM uses a `.env` file located in the project root `/Arctyk/.env` to manage configuration.
This file is automatically loaded when running:

```bash
docker compose up -d
```

Here’s an example `.env` configured for the default Arctyk ITSM stack:

```bash
# ─── General Settings ─────────────────────────────
DEBUG=False
SECRET_KEY=your-strong-secret-key
ALLOWED_HOSTS=localhost,127.0.0.1,arctyk.local

# ─── Database Configuration ───────────────────────
DB_NAME=arctyk
DB_USER=arctyk
DB_PASSWORD=arctyk_password
DB_HOST=db
DB_PORT=5433

# ─── Email Settings ───────────────────────────────
EMAIL_BACKEND=django.core.mail.backends.smtp.EmailBackend
EMAIL_HOST=smtp.office365.com
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=helpdesk@yourdomain.com
EMAIL_HOST_PASSWORD=yourpassword
DEFAULT_FROM_EMAIL=helpdesk@yourdomain.com

# ─── Localization ─────────────────────────────────
TIME_ZONE=America/Toronto
LANGUAGE_CODE=en-ca

# ─── Optional Features ────────────────────────────
ENABLE_JIRA=False
ENABLE_ZENDESK=False
ENABLE_POWER_PLATFORM=False
ENABLE_CELERY=True
ENABLE_CHANGELOG=True

```
!!!Tip
    Never commit your `.env` file to version control.
    Keep it local or managed securely via Docker Secrets, Vault, or CI/CD environment settings.

## Docker Compose Configuration

Your `docker-compose.yml` defines the Arctyk ITSM runtime stack:

```yaml
version: "3.9"

services:
  web:
    build: .
    container_name: arctyk_web
    command: >
      sh -c "python manage.py migrate &&
             python manage.py collectstatic --noinput &&
             gunicorn helpdesk.asgi:application -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:8000"
    volumes:
      - .:/code
      - static_volume:/code/staticfiles
      - media_volume:/code/media
    ports:
      - "8000:8000"
    env_file:
      - .env
    depends_on:
      - db
    restart: unless-stopped

  db:
    image: postgres:17
    container_name: arctyk_db
    environment:
      POSTGRES_DB: ${DB_NAME}
      POSTGRES_USER: ${DB_USER}
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    ports:
      - "5433:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data
    restart: unless-stopped

volumes:
  postgres_data:
  static_volume:
  media_volume:
```

This configuration ensures:

- The web service builds your Django app and runs via Gunicorn + UvicornWorker.
- The db service runs PostgreSQL 17 on port 5433.
- Static and media files persist via Docker volumes.

## Django Settings Overview
Arctyk ITSM’s `helpdesk/settings.py` automatically loads configuration from your `.env`.
You rarely need to modify this file directly — just adjust the environment values.

Key settings linked to your `.env`:

| Setting         | Description                    | Example                   |
| --------------- | ------------------------------ | ------------------------- |
| `DEBUG`         | Enables or disables debug mode | `False`                   |
| `SECRET_KEY`    | Unique Django secret key       | `your-strong-secret-key`  |
| `ALLOWED_HOSTS` | Allowed domains                | `localhost, arctyk.local` |
| `DATABASES`     | Database connection details    | Loaded from `.env`        |
| `EMAIL_*`       | SMTP configuration             | Loaded from `.env`        |
| `TIME_ZONE`     | Django timezone                | `America/Toronto`         |


## Database Configuration
Arctyk ITSM uses PostgreSQL as its default database.
Your connection is fully defined in `.env`, and mapped in `docker-compose.yml` under the db service.

If your PostgreSQL server runs externally or on a different port, update:

```bash
DB_HOST=your-db-server-host
DB_PORT=5433
```
To apply changes:

```bash
docker compose down
docker compose up -d
```

You can verify the connection inside the web container:

```bash
docker compose exec web python manage.py dbshell
```

## Email Configuration

Email enables features like:

- Ticket creation/assignment notifications
- Password reset emails
- Daily summaries

Use the SMTP backend (recommended for production):

```bash
EMAIL_BACKEND=django.core.mail.backends.smtp.EmailBackend
EMAIL_HOST=smtp.office365.com
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=helpdesk@yourdomain.com
EMAIL_HOST_PASSWORD=yourpassword
DEFAULT_FROM_EMAIL=helpdesk@yourdomain.com
```
To test your setup:

```bash
docker compose exec web python manage.py sendtestemail helpdesk@yourdomain.com
```

## Optional Features
Arctyk ITSM includes modular integrations you can enable as needed.
Set the following in your `.env` file:

| Feature          | Variable                | Default | Description                                  |
| ---------------- | ----------------------- | ------- | -------------------------------------------- |
| Jira Integration | `ENABLE_JIRA`           | `False` | Connect tickets with Jira issues             |
| Zendesk Bridge   | `ENABLE_ZENDESK`        | `False` | Sync with existing Zendesk data              |
| Power Platform   | `ENABLE_POWER_PLATFORM` | `False` | Allow Power Automate / Power Apps API access |
| Scheduled Tasks  | `ENABLE_CELERY`         | `True`  | Enable Celery for background jobs            |
| Change Logging   | `ENABLE_CHANGELOG`      | `True`  | Track changes to assets and tickets          |

## Security Recommendations

Before going live:

- Set `DEBUG=False`
- Use a long, unique `SECRET_KEY`
- Limit `ALLOWED_HOSTS` to your actual domain
- Serve over `HTTPS` behind a reverse proxy (e.g. NGINX)
- Keep `.env` and database volumes out of version control
- Schedule regular backups for:
    - `/var/lib/postgresql/data`
    - `/code/media`
    - `.env` and configuration files

## Next Steps

Once configuration is complete, proceed to:

- Continue to [Deployment →](deployment.md)
 to run Arctyk ITSM in production.

- Or explore the [User Guide →](../user-guide/tickets.md)
 to start creating and managing tickets.