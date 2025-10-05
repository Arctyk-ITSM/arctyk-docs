# Arctyk ITMS - Project Setup

## Guide Requirements

This guide assumes you are using Windows 11, Visual Studio Code and PowerShell.

## Package Versions

| App       | Project Version | Available Version |
|-----------|-----------------|-------------------|
| pip       | 24.3.1          | 25.2              |
| Django    | 5.1.5           | 5.2.5             |
| Python    | 3.1.2           | 3.13.7            |
| Postgre   | 17.2            | ???               |
| pip       | 24.3.1          |  25.2             |

## Setup Project & Virtual Environment

The following commands will setup the project and virtual environment.

```PowerShell 
mkdir dashboard && cd dashboard # make dashboard and switch to it
py -m venv .venv                # setup virtual environment
.venv\Scripts\Activate.ps1      # activate environment
py -m pip install --upgrade pip # install pip package manager
py -m pip install Django==5.1.5 # LTS

django-admin startproject config . # run Django project scaffold
python manage.py startapp dashboard # create dasboard app scaffold
```

## Visual Studio Code Setup

### Useful extensions

- djlint `pip install -U djlint`

## Django Templates

Templates can be stored at the project level or at the app level. Template settings are configured in `src/settings.py`. 

`DIRS` sets the project-level directories for templates.

`APP_DIRS` enables or disables app-level templates. This should always be set `APP_DIR=True` for Arctyk ITSM projects. We use app-level templates.

```
TEMPLATES = [
    {
        "BACKEND": "django.template.backends.django.DjangoTemplates",
        "DIRS": [BASE_DIR / "templates"],  # project-level templates
        "APP_DIRS": True,                  # enables app-level templates
        "OPTIONS": {
            "context_processors": [
                "django.template.context_processors.debug",
                "django.template.context_processors.request",
                "django.contrib.auth.context_processors.auth",
                "django.contrib.messages.context_processors.messages",
            ],
        },
    },
]

```

### Project-Level Templates

Global/shared templates are stored in `src/templates/`. (e.g. base.html, breadcrumbs.html)

This allows for extending `base.html` and/or including `breadcrumbs.html` from anywhere.

### App-Level Templates

App-specific templates are stored at the app level. For example, tickets_list.html, tickets_detail.html are stored in `src/tickets/templates/tickets`. 

### Template References in Views

Views should reference templates as shown in the example below.

```

template_name = "tickets/tickets_list.html"

```

and

```

return render(request, "tickets/ticket_detail.html", {...})

```

Django will resolve them automatically. 

### Template references in frontend

The most important template is `base.html`. This is the template that provides the overall appearance, structure and UI/UX for Django. Simply put, `base.html` contains the main navigate, sidebar and footer for Arctyk ITSM. It is a global template located at `src/templates/base.html`. 

App templates can extend `base.html` using `{% extends "base.html" %}`. 

### Global Templates List

- src/templates/base.html    # bass template for entire project
- src/templates/home.html    # frontpage 

### App Templates List

#### Tickets App

This is the current list of ticket app templates as of v0.6.0-alpha.1.

- src/tickets/templates/tickets/tickets_list.html
- src/tickets/templates/tickets/create_ticket.html
- src/tickets/templates/tickets/ticket_detail.html
- src/tickets/templates/tickets/bulk_edit.html
- src/tickets/templates/tickets/archived_list.html
- src/tickets/templates/tickets/edit_ticket.html
- src/tickets/templates/tickets/ticket_confirm_delete.html
- src/tickets/templates/tickets/schedule_ticket.html
- src/tickets/templates/tickets/tickets_by_tag.html
- src/tickets/templates/tickets/ticket_list.html           # optional legacy from previous versions