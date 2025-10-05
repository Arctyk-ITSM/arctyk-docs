# Docker Commands

Here are some useful Docker commands for quick reference.


## Docker Commands
- `docker compose up --build` # restart docker after code changes and build container
- `docker compose up -d --build` # starts in **detatched** mode which starts your services in the background
- `docker compose up -d` # start the stack - brings up Django/Gunicorn/Uvicorn ASGI, Postgres and nginx (if installed)
- `docker compose down` # shutdown docker / stop app
- `docker compose down -v` # shutdown docker and remove volumes to reset the DB container
- `docker compose restart web` # restart a service
- `docker compose ps` # check status
- `docker compose logs -f` # see live logs
- `docker compose run --rm web python src/manage.py createsuperuser` # creates a superuser
- `docker compose -f docker-compose.yml -f docker-compose.override.yml exec web python src/manage.py makemigrations`  # makemigration using multiple compose files
- `docker compose -f docker-compose.yml -f docker-compose.override.yml exec web python src/manage.py migrate`  # migrate using multiple compose files
- `docker compose run web python src/manage.py migrate` # migrate the database to the container
- `docker compose run --rm web python manage.py collectstatic --noinput` # run when changes have been made to static files (CSS, JS, etc.)
- `docker compose run --rm web pytest` # run tests
- `docker system prune -af`  # will remove unused containers, networks, images, and cache



## Docker Command Flags
- `-d` = detached mode
  - starts services in background and returns you to the prompt when finished running command
- `--build` = Builds/re-builds images before starting
  - Useful after code or Dockerfile changes
- `--rm` = remove the container when it exits (auto-cleanup)
  - Deletes stopped container right after the command finishes
  - Prevents clutter from lots of exited contaienrs
  - It doesn't remove images
  - It doesn't remove volumens
  - It doesn't affect networks created by Compose
  - Use with one-shot tasks: `migrate`, `collectstatic`, `createsuperuser`, ad-hoc scripts

## Project Dependencies

If you updated dependencies (e.g. changed requirements.txt) you will need to rebuild the Docker image.

To rebuild:

```bsh
docker compose build web
```
Or to rebuild everything:

```bash
docker-compose build
```
