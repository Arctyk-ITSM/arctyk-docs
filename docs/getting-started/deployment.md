# Deployment

This guide explains how to deploy Arctyk ITSM to a production environment using Docker Compose.
It builds on your installation and configuration steps to ensure your instance runs securely, efficiently, and automatically restarts on failure.

!!! Warning
    The deployment documentation is a work-in-progress and should not be used with caution.

## Prerequisites

Before you deploy, make sure you have:

| Requirement           | Description                                                                             |
| --------------------- | --------------------------------------------------------------------------------------- |
| **Docker**            | Installed on your host server (`docker --version`)                                      |
| **Docker Compose**    | Version 2.0 or later (`docker compose version`)                                         |
| **Domain Name**       | Example: `itsm.example.com`                                                             |
| **SSL Certificate**   | Provided by Let’s Encrypt or your organization                                          |
| **Configured `.env`** | Contains environment variables for production (see [Configuration →](configuration.md)) |


## Production-Ready Docker Compose
Your base `docker-compose.yml` file already defines web and db.
For production, extend it by adding NGINX as a reverse proxy and `static/media` volumes for persistence.

Example: `docker-compose.prod.yml`

```yaml
version: "3.9"

services:
  web:
    build: .
    container_name: arctyk_web
    command: >
      sh -c "
      python manage.py migrate &&
      python manage.py collectstatic --noinput &&
      gunicorn helpdesk.asgi:application -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:8000
      "
    volumes:
      - .:/code
      - static_volume:/code/staticfiles
      - media_volume:/code/media
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
    volumes:
      - postgres_data:/var/lib/postgresql/data
    restart: unless-stopped

  nginx:
    image: nginx:1.27-alpine
    container_name: arctyk_nginx
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx/conf.d:/etc/nginx/conf.d
      - static_volume:/code/staticfiles
      - media_volume:/code/media
      - /etc/letsencrypt:/etc/letsencrypt  # for SSL
    depends_on:
      - web
    restart: unless-stopped

volumes:
  postgres_data:
  static_volume:
  media_volume:
```

## Configure NGINX

Create a new folder for your NGINX configuration:

```bash
mkdir -p nginx/conf.d
```

Then add your config file:
nginx/conf.d/arctyk.conf

```ngnix
server {
    listen 80;
    server_name itsm.example.com;

    location /static/ {
        alias /code/staticfiles/;
    }

    location /media/ {
        alias /code/media/;
    }

    location / {
        proxy_pass http://web:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    # Redirect all HTTP traffic to HTTPS (optional)
    # return 301 https://$host$request_uri;
}
```
For SSL, you can extend this with Let’s Encrypt (see below).

## Enable HTTPS (Let’s Encrypt)
You can add Certbot to your stack or use your organization’s SSL certs.

To use Let’s Encrypt:

1. Run Certbot on the host (not inside Docker):

```bash
sudo apt install certbot
sudo certbot certonly --standalone -d itsm.example.com
```
2. Mount your certificate paths into the NGINX container:

```yaml
- /etc/letsencrypt:/etc/letsencrypt
```
3. Update your NGINX config to use HTTPS:
        
```ngnix
    server {
    listen 443 ssl;
    server_name itsm.example.com;

    ssl_certificate /etc/letsencrypt/live/itsm.example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/itsm.example.com/privkey.pem;

    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

    location /static/ {
        alias /code/staticfiles/;
    }

    location /media/ {
        alias /code/media/;
    }

    location / {
        proxy_pass http://web:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```
## Collect Static Files

To ensure Django serves all assets properly:

```bash
docker compose -f docker-compose.prod.yml exec web python manage.py collectstatic --noinput
```
Static files will be stored in the `static_volume` and mounted by NGINX.

## Apply Database Migrations

Before first use or after updates:

```bash
docker compose -f docker-compose.prod.yml exec web python manage.py migrate
```
Optionally, create a superuser:

```bash
docker compose -f docker-compose.prod.yml exec web python manage.py createsuperuser
```
## Starting the Stack

Launch the production stack:

```bash
docker compose -f docker-compose.prod.yml up -d --build
```
View logs:

```bash
docker compose logs -f web
docker compose logs -f nginx
```
Restart after updates:

```bash
docker compose restart web
```

# Maintenance Tips

| Task                | Command                                                            |
| ------------------- | ------------------------------------------------------------------ |
| Rebuild containers  | `docker compose -f docker-compose.prod.yml up -d --build`          |
| Stop the stack      | `docker compose down`                                              |
| Run Django shell    | `docker compose exec web python manage.py shell`                   |
| Backup database     | `docker compose exec db pg_dump -U $DB_USER $DB_NAME > backup.sql` |
| Restore database    | `docker compose exec -T db psql -U $DB_USER $DB_NAME < backup.sql` |
| Clean unused images | `docker system prune -af`                                          |

# Automating with Systemd (Optional)
For environments without container orchestration, you can auto-start Docker Compose on boot:

```bash
sudo nano /etc/systemd/system/arctyk.service
```
Example unit file:

```bash
[Unit]
Description=Arctyk ITSM Docker Compose
After=docker.service
Requires=docker.service

[Service]
WorkingDirectory=/opt/arctyk
ExecStart=/usr/bin/docker compose -f docker-compose.prod.yml up -d
ExecStop=/usr/bin/docker compose -f docker-compose.prod.yml down
Restart=always

[Install]
WantedBy=multi-user.target
```
Then:

```bash
sudo systemctl enable arctyk
sudo systemctl start arctyk
```

## Post-deployment Checklist
-  DEBUG=False
- ALLOWED_HOSTS updated to your domain
- SSL configured and auto-renewing
- Superuser created and admin access verified
- Static & media volumes persistent
- Database backup procedure tested

## Next Steps

Once deployed, you can:

- Continue to User Guide →
to start creating and managing tickets.

- Or check Developer Guide →
to understand the system architecture and modular apps.