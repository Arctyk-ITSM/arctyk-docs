# Docker Setup for Deployment to Digital Ocean

## File structure

arctyk/
- manage.py
- Dockerfile
- docker-compose.yml
- docker-compse-override.yml # override for development
- .env
- requirements.txt
- config/                <-- Django project folder
  - settings.py
   - ...
- app_name/             <-- your Django app(s)

## Docker Commands
- `docker-compose up --build` #start docker and build container
- `docker-compose up` # start docker and serve web app
- `docker-compose down` # shutdown docker / stop app
- `docker-compose down -v` # shutdown docker and remove volumes to reset the DB container
- `docker-compose run web python src/manage.py migrate` # migrate the database to the container
- `docker compose run web src/manage.py collectstatic --noinput`  # compiles static files

If you updated dependencies, run `docker-compose build`.

Access web server: `http://localhost:8000`
