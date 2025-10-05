# Arctyk ITMS - Project Overview

## Project Structure

Root directory of the project should be Arctyk. Below is an example of the high level directory structure of the project.

- **Arctyk/**
  - **github**
    - **ISSUES_TEMPLATES** — Templates for users reporting Issues on GitHub repo
    - **workflows** — GitHub specific workflows
  - **.venv/** — Environment files for local development (ignored)
  - **node_modules/** — Node JS packages / Tailwind package
  - **docs/** — Markdown files used to build documentation website
    - **INSTRUCTIONS.md**
      - **Project_Setup.md**
      - **index.md**
      - **getting-started.md**
  - **changelog/** — Changelog app 
  - **src/**
    - **config/** — settings / urls / ASGI
    - **core/** — core app for global and reusable components
    - **dashboard/** — dashboard app
    - **tickets/** — tickets app
    - **users/** — users app
    - **projects/** — projects app
    - **reports/** — reports app
    - **templates/** — HTML / frontend pages 
    - **inventory/** — assets / inventory app
    - **media/** — profile pictures & other user uploads
    - **staticfiles/** — CSS / JS / images for frontend *(CSS outputted from STATIC_SRC/)*
    - **STATIC_SRC/** — Bootstrap / SCSS / CSS for building styles
  - **manage.py** — Django command-line tasks & config
  - **.gitignore**
  - **.flake8**
  - **.pre-commit.config.yaml** — Black / Flake8 / pre-commit settings
  - **requirements.txt** — Python package requirements
  - **requirements.in** — Python package requirements
  - **dev-requirements.txt** — Python development package requirements
  - **dev-reqiurements.in** — Python development package requirements
  - **mkdocs.yml** 
  - **package-lock.json**
  - **package.json**
  - **README.md**
  - **TODO.md**

## Envnironment
All environment settings for this project are contained in `Arctyk\.venv` folder. The `.venv` folder will include the nessecary tools to run the environment on the local system. 

The contents of the .venv folder should follow the structure shown below when properly setup.

- .venv                 # Keep in `.gitignore` so you never push site-packages
  - include/
  - Lib/
  - Scripts/           # Activate / Deactivate environement scripts (PowerShell)                
  - pyvenv.cfg        # Envrionment config settings

**Activate the environment:** `.venv\Scripts\Activate.ps1`        # From root directory

**Deactivate the environment:** `deactivate`

## Database 
Certian changes require the database to be updated. In these cases, you must migrate the new changes to the existing database.

1. **Stage the migration:** `python src/manage.py makemigrations` 
2. **Run the migration:** `python src/manage.py migrate`

## Local Server (without Docker)
Once your environment and Django are installed and configured, you can run the web app locally in a browser. 

1. **Start the server:** `python src/manage.py runserver`
2. **Open the URL from terminal**: `http/127.0.0.1:8000/`

## Install pip tools
We need to install `pip-tools` if you don't already have it installed in your envronment. It is needed to manage project requirements. 

- `pip install pip-tools`

## Projects Requirements
We use "requirements" to track and build packages for the project. There are 2 types of requirement files for our project.

1. **Local Development Requirements** - `dev-requirements.txt` / `dev-requirements.in`
    - These files list runtime and development tools.
2. **Prouction Requirements** - `requirements.txt` / `requirements.in`
   - These files list the runtime stack needed for production.

### Create requirements files (if needed):
If you are building the project from scratch, you may not have **requirements.txt** or **dev-requirements.txt**. If not, you will need to create them.

**Create dev-requirements**

From project root:

1. Create `dev-requirements.in` file and add the line `-r requirements.in` as the first line in the document. T
2. Add the list of dev tools below the first line.
2. Run `pip-compile dev-requirements.in` to generate `dev-requirements.txt`.
3. You can use `pip-sync` to update/install in one go. Example: `pip-sync dev-requirements.txt`.

```
pip-compile --generate-hashes requirements.in
pip-compile --generate-hashes dev-requirements.in
```
(produces requirements.txt & dev-requirements.txt (pinned w/ hashes))

1. Build the main project with **requirements**: `pip install -r requirements.txt`. 
2. Build the project **dev requirements**:  `pip install -r dev-requirements.txt`.
3. If you need tests/lint; in runtime image use: `pip-sync requirements.txt`.

  - To update `requirements.in` run: `pip-compile requirements.in`. 

**Command line tools:**

1. pip `python.exe -m pip install` or upgrade `python.exe -m pip install --upgrade pip`
  - `pip-compile --generate-hashes requirements.in`
  - `pip-sync dev-requirements.txt`
2. Black `pip install -U black`
3. Flake8 `pip install -U flake8`
4. Pre-commit `pip install -U pre-commit`

## Pre-commit

Pre-commit is a light-weight framework that runs automated checks every time you create a Git commit. It works like a "gatekeeper" between your working tree and your reposoitory history. It is basic quality control. 

**Why it's useful in Arctyk ITMS:**

- Guarantees every commit is formated (Black) and lint-clean (Flake8)
- Ensures generated files - like `requirements*.txt` - are up-to-date.
- Catches stray debug points, large files, or secrets before they land in Git.
- Works identically on Windows, macOS, Linux, and in CI because hookes are version-pinned.

**Insalling & Using Pre-commit:**

1. `.\.venv\Scripts\activate`
2. `pip install -U pre-commit`
3. `pre-commit install`         # installs the git hook if not already
4. `pre-commit run --all-files`  # run it now

## Git / GitHub

1. **Stage files to commit:** `git add -A`            # This stages all files. Replace -A with the file path to stage individual directories or files
2. **Add comment to the commit:** `git commit -m "chore: clean stray venv, tune Flake8"`
3. **Push to Git:** `git push origin dev`             # Replace `dev` with the name of the repo you want to push too

## Django Overview

There are certain tools we can use to work with Django and run system tests.

- **Run Django system test:** `py src/manage.py check`
- **Start the local server:** `py src/manage.py runserver`
- **Stage migration:** `py src/manage.py makemigrations`
- **Run migration:** `py src/manage.py migrate`
- **Find Django version:** `py src/manage.py --version` or `py -m django --version`

## Design System

Please see `design-system.md` for more information about our design system.



