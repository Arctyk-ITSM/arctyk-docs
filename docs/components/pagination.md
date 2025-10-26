**Pagination** is a global feature which provides a consistent experience across all Arctyk apps.

Pagination should be added to any list page (e.g. Users, Tickets, Assets, etc.). It is configured to automatically adapts its empty-state text and behavior — without writing a single extra line of code in the template.

| Feature                      | Behavior                   |
| ---------------------------- | -------------------------- |
| Auto-detect base URL         | ✅ Works with any list view |
| Keeps filters/search/sort    | ✅ Preserves all params     |
| Collapsible long page ranges | ✅ “1 … 5 6 7 … 20”         |
| Bootstrap icons              | ✅ No entity references     |
| Reusable across apps         | ✅ Users / Assets / Tickets |
| Auto-scroll-to-top           | ✅ When switching pages     |

## Location

```
templates/partials/pagination.html
```


---

## Usage
For basic usage, you would add the following to any template:

```
{% include "partials/pagination.html" %}
```


## Usage within Arctyk Templates

The following snippets show how pagination should be added to a template in an Arctyk app. The snippet should include a comment, div tags Bootstrap class applied. 

The include statements should reference the model, view an page_obj which allows us to customize it for each app. It will also dynamically display context-aware messages.

In **Users list:**

```html
 <!-- Pagination -->
<div class="mt-3">
	{% include "partials/pagination.html" with page_obj=page_obj model_name="users" view_name="user_list" %}
</div>
```


In **Assets list:**

```html
<!-- Pagination -->
<div class="mt-3">
	{% include "partials/pagination.html" with view_name="asset_list" model_name="assets" %}
</div>
```


In **Tickets list:**

```html
<div class="mt-3">
	{% include "partials/pagination.html" with view_name="ticket_list" model_name="tickets" %}
</div>
```


---

## Visibility

This condition controls everything:

```
{% if page_obj and page_obj.paginator.num_pages > 1 %}
```

That line checks:

1. Whether a `page_obj` exists (so the view passed paginated data), **and**    
2. Whether the total number of pages (`num_pages`) is **greater than 1**.
    

If there’s **only one page of results** (e.g. < 10 items for a 10-item paginator):  
The entire `<nav>` block and `<ul class="pagination">` are **skipped entirely**.

If there are **no results at all** (e.g. an empty list):  
Since `page_obj` still exists but `paginator.num_pages` == 1 (or 0), it’s also hidden.

| Case                           | Pagination Visible?   |
| ------------------------------ | --------------------- |
| Multiple pages of results (2+) | ✅ Yes                 |
| Single page of results         | 🚫 No                 |
| No results at all              | 🚫 No                 |
| Non-paginated list             | 🚫 No (no `page_obj`) |

---
## Requirements

Make sure you have the **helper tag** available once globally — it’s what preserves filters and sorting:

**Location:** `core/templatetags/querystring_tags.py`

```ad-note
Remember to load it at the top of any template using pagination:

`{% load querystring_tags %}`

```
