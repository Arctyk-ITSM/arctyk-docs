# Design - UI Components

## Bootstrap used in Arctyk ITSM

### Containers

| Selector  |  Where to use     |
|-----------|-------------------|
| body      |  `base.html`      |
| .container-lg | `edit_profile`, `edit_user`  |


## Django Linting & Styles

### Django Block Tags
Endblock tags must contain the matching name of the start block tag or it will be flagged as a linting error.

**Example:**

```python
{% block title %}Users – Arctyk ITSM{% endblock title %}
```
### Block Tags Require Whitespace:

All block tags require whitespace between the `{%` and `block text` and `%}`. Otherwise it will result in linting error.

### Inline Styles
Inline styles should be avoided. When possible, use default **Bootstrap v5.3** `class` and `id` attributes for styles. 

**Example:**

```html
<img src="{{ user.profile.picture.url }}"
     alt="Profile Picture"
     class="img-thumbnail"
     width="150"
     height="150">
```

If it is not possible to use default Bootstrap styles, you will need to create a custom style in `_site.scss` or `app.scss`.

### Images
Images should include the following:

- Img tag should have height and width attributes.
- Img tag should have defined `alt` atrributes

**Example:**
```html
<img src="{{ user.profile.picture.url }}"
     alt="Profile Picture"
     class="img-thumbnail"
     width="150"
     height="150">
```


