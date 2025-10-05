# Django Overview

Official Site: https://djangoproject.com

**Django Versioning:**
- Use older version if you're running an existing project that hasn't been migrated 
- Use the latest LTS verion when possible.
- x.2 versions will have long term support (LTS)

**Python Version:**
- Must use a compatible version for Django

## Architecture

1. User sends an HTTP request to Django
2. URL configuration, contained in `urls.py` selects a View to handle the request
3. The View gets the request and
    - Talks to a database via the Models
    - Renders an HTML Template
4. The View returns an HttpResponse which gets sent to the client to be rendered as a web page in the browser.


## Django Project & Apps
The default folders and files created by Django.

- django_app *(project root)*
    - manage.py
    - django_app *(default name copies the project name)*
        - `__init__.py`
        - settings.py
        - urls.py
        - wsgi.py
        - asgi.py

### manage.py
This file is used to run the project.
- `runserver` - Run the development server
- `migrate` - Apply migrations to the database
- `createsuperuser` - Create a super user in the database
- `shell` - Run a python console (has access to Django Project)
- `makemigrations` - If models changed, create migration file

Run `py migrate.py` without arguments to see a list of all available commands.

### django_app (second level django_app / django_app)
This is where the overall configuration of your site goes. The default is to have the name as the project but some people will rename it "config" as in Arctyk ITSM project.

#### settings.py
This defines the Django settings for the site. 
- Notable settings:
    - DEBUG mode (must turn off in production)
    - Database settings (don't use SQList in production - we use Postgres in Arctyk ITSM)
    - Installed apps
    - Timezone
    - Static and media folder locations
    - Password validators

#### urls.py
This defines the URLS for the site. We can determine how we want to build links using `urlpatterns`. 
Examples from Arctyk ITSM:
- `/`  # index
- `path("admin/", admin.site.urls),`  # path to the admin app
- `path("tickets/", include(("tickets.urls", "tickets"), namespace="tickets")),` # path to tickets app

#### wsgi.py 
**WSGI - Web Server Gateway Interface**. It provides an interface for running the application in production with a dedicated web server (like ngnix or Apache)

#### asgi.py
**ASGI - Asynchronouse Server Gateway Interface**. Similar to WSGI but for asynchronous web servers. 
- Allows support for websockets, async and HTTP/2

### `__init__.py`
This file is used to tell Django that this folder contains python code. Also known as "dunder init" for the double underscores surrounding the word init. 


## Virtual Environment
Why we need to create a virtual environment:

- You may have multiple Python versions on your computer
- You may have projects that require different verisons of the same external package
- Virtual environments create a "workspace" environment for a specific project
    - All installed packages are in one place, without conflicts
    - The "python" and "pip" commands point to the same place
    - Keeps your environment clean

 ## Create Virtual Envrionment (Local)
 From the console, navigate to the project root folder. The commands below will create a new folder in the project named `venv` which will have all of the files required to run a virtual envrionment. 

 **Linux/Mac:**
 `python3.12 -m venv venv`

 **PowerShell:**
 `python3.12 -m venv venv` or `py -m venv venv`

 ## Run the Virtual Environment
 The following is also done from the Django Project root directory. The commands will run an activate script located in the `venv` directory. 

 **Linux/Mac:**
 `source venv/bin/activate`

 **PowerShell:**
 `venv/bin/Activate.ps` or `.venv/Scripts/Activate.ps1` with Arctyk ITSM.

 ## Install Django
 Once your virtual environment has been activated, install Django using pip.

 `pip install django` to install the latest version of Django

## Manage Django

`py manage.py` or  `python manage.py`

## Migrate Database

`python manage.py migrate`

## Create Super User

```PowerShell
python manage.py create_superuser
Username: admin
Email address: test@test.com
Password:
```
