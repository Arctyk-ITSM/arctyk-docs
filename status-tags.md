# Working with Status Tags

Status tags are used in the tickets app to indicate the status of a ticket. Status tags make use of the Bootstrap 5 badge component and we may use the terms **Status Tag** and **Status Badge** interchangably throughout our documentation. 

## Status Tag Options

| Status  | Colour | Hex Value |
--------------------------------
| New     | Red     | #dc3545  |
| Open    | Orange  | #ffc107  |
| In Progress | Blue  | #5DA9E9 |
| On Hold | Blue  | #5DA9E9 |
| Recurring | Blue  | #5DA9E9 |
| Blocked | Yellow  | #F8DD5D |
| Solved | Green  | #28a745 |
| Closed | Green  | #28a745 |

### Other Important Tags

There are a couple of other important tags related to tickets. 

- **Archived** indicate tickets that have been archived by an admin.
- **Overdue** indicate any tickets that are not Solved/Closed which remain open past their assigned Due Date.

## Configuring Status Tags

Status tags are currently hard-coded into the system and configuring them is a manual process. In the future, admins will be able to manage and customize them through Admin Settings. 

There are two primary files you need to configure tags: 

1. `src/STATUS_SRC/scss/app.scss`
2. `src/core/templatetags/form_tags.py`

### app.scss

`app.scss` is where the CSS for Status tags are defined. We must override the default Bootstrap badges styles in order to create our own custom badge colours. 

```
  $theme-colors: (
    /* Custom statuses */
    "new": #dc3545,
    "open": #ffc107,
    "in_progress": #5DA9E9,
    "recurring": #5DA9E9,
    "solved": #28a745,
    "closed": #28a745,
    "blocked": #F8DD5D,
    "on_hold": #5DA9E9,
  )

```

### form_tags.py

`form_tags.py` is where we register our function in Django and map our custom Status tags to Bootstrap. `form_tags.py` is located in `src/core/templatetags/` which is part of the **Core app**. 

Below is the function inside `form_tags.py`. 

```

@register.filter(name="status_badge")
def status_badge(status):
    mapping = {
        "new": "badge rounded-pill text-bg-new text-light",
        "open": "badge rounded-pill text-bg-open text-light",
        "in_progress": "badge rounded-pill text-bg-in_progress text-light",
        "on_hold": "badge rounded-pill text-bg-on_hold text-light",
        "blocked": "badge rounded-pill text-bg-blocked text-light",
        "solved": "badge rounded-pill text-bg-solved text-light",
        "closed": "badge rounded-pill text-bg-closed text-light",
    }
    return mapping.get(status, "badge rounded-pill text-bg-secondary")

```
