# Arctyk ITSM Installation Guide (Docker)

This guide explains how to set up a **fresh installation** of Arctyk ITSM using Docker and Docker Compose. 

By the end of this procedure, you’ll have the application running locally with a Postgres database.

## Prerequisites
 Make sure the following are installed on your system:

- [Docker](https://docs.docker.com/get-docker/) (v24+ recommended)
- [Docker Compose](https://docs.docker.com/compose/install/) (v2.x)
- Clone the repo:

```bash
git clone https://github.com/Arctyk-ITSM/arctyk.git
cd arctyk
```
## Project Structure

Your repo should look like this:

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

## Environment Variables

Create a `.env` file in the project root:

```evn
# Django
DJANGO_SECRET_KEY=super-secret-key
DJANGO_DEBUG=True
DJANGO_ALLOWED_HOSTS=*

# Database
POSTGRES_DB=arctyk
POSTGRES_USER=arctyk
POSTGRES_PASSWORD=arctyk
POSTGRES_HOST=db
POSTGRES_PORT=5432

# Static / Media
STATIC_ROOT=/code/static
MEDIA_ROOT=/code/media
  ```
  
## Docker Compose File

Example `docker-compose.yml`:

```yaml
version: "3.9"

services:
  db:
    image: postgres:17
    restart: always
    environment:
      POSTGRES_DB: ${POSTGRES_DB}
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
    ports:
      - "5433:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data

  web:
    build:
       context: .
       dockerfile: docker/web.Dockerfile
    command: >
      sh -c "python src/manage.py migrate &&
              python src/manage.py collectstatic --noinput &&
              gunicorn helpdesk.asgi:application -k uvicorn.workers.UvicornWorker -b 0.0.0.0:8000"
    volumes:
      - .:/code
    env_file: .env
    ports:
      - "8000:8000"
    depends_on:
      - db

volumes:
    postgres_data:
```

## Dockerfile for Web

In `docker/web.Dockefile`:

```dockerfile
# Use a slim Python base
FROM python:3.13-slim

ENV PYTHONUNBUFFERED=1 \
      PYTHONDONTWRITEBYTECODE=1

WORKDIR /code

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential libpq-dev libjpeg-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
```
## Build and Run

Build and start containers:

```bash
docker compose up -d --build
```
Check logs:

```bash
docker compose logs -f
```
## Automatic Admin User

Arctyk ITSM automatically creates a default superuser/admin account the first time the app starts if one does not already exist.

  - **Username:** `admin`
  - **Pasword:** `adminpass`
  - **Email:** `admin@example.com`

## Database Setup

Once the containers are running, run migrations:

```bash
docker compose exec web python src/manage.py migrate
```

Create a superuser:

```bash
docker compose exec web python src/manage.py createsuperuser
```

## Access the App

  - Web App: [http://localhost:8000](http://localhost:8000)
  - Admin Panel: [http://localhost:8000/admin/](http://localhost:8000/admin/)

## First-Run Data Setup

(Optional) Load fixtures or auto-create data like `HelpdeskSettings`:

```bash
docker compose exec web python sr/manage.py loaddata initial_data.json
```

## Stopping & Restarting

```bash
docker compose down # stop
docker compuse up -d  # restart
```

## That's It!

You should now have a fully running Arctyk ITSM instance inside Docker.

## Next Steps

Once configuration is complete, proceed to:

- Continue to [Configuration →](configuration.md)
 to run Arctyk ITSM in production.

- Or explore the [User Guide →](../user-guide/tickets.md)
 to start creating and managing tickets.