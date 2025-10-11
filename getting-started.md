# Arctyk ITMS - Project Overview

## Current Version
v0.5.0-alpha.0

## Project Structure
Root directory of the project should be Arctyk. Below is an example of the high level directory structure of the project.

- **Arctyk/**
  - **.venv/** — Environment files for local development (ignored)
  - **node_modules/** — Node JS packages / Tailwind package
  - **src/**
    - **config/** — settings / urls / ASGI
    - **tickets/** — tickets app
    - **users/** — users app
    - **projects/** — projects app
    - **reports/** — reports app
    - **templates/** — HTML / frontend pages
    - **inventory/** — assets / inventory app
    - **media/** — profile pictures & other user uploads
    - **static/** — CSS / JS / system images
    - **dashboard/** — dashboard app
  - **manage.py** — Django command-line tasks & config
  - **.gitignore**
  - **.pre-commit.config.yaml** — Black / Flake8 / pre-commit settings
  - **INSTRUCTIONS.md**
  - **README.md**
  - **TODO.md**
  - **requirements.txt** — Python package requirements
  - **package-lock.json**
  - **package.json**