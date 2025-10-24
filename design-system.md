# Design System

Guidelines, standards and documentation for the design system, components and elements of Arctyk ITSM.


## Time & Date

Default time should use `UTC time` in `24-hour format`.

Default date should use the following format: `2025-07-21`.

**How to use:**

Displaying the date and time together: `date:"Y-m-d H:i"` outputs to `2025-07-21 20:02`.

Example from ticket_detail.html: 

```html
<p class="card-text"><strong>Created:</strong> {{ ticket.created_at|date:"M d, Y h:i a" }}</p>
```


## Bootstrap, SCSS & CSS
Install Dart Sass: `npm install -g sass` if required.

All custom CSS should be added to `STATIC_SRC/scss/_site.scss` or `STATIC_SRC/scss/app.scss`.

After changes are made, run the following command to build the output:

`npm run build:css`

This command will generate the output to `STATIC_SRC/css/`.

If this is for a production server, you will also need to run the following code:

`py src/manage.py collectstatic --noinput`

The collectstatic command will copy updated static files to **src/staticfiles** to be served on the frontend of the website/app.

The `npm run build:css` command is defined in **package.json**. The the code below. It defines the instructions for loading, compressing the files and maps the path for the watch and output to.

```
"scripts": {
    "build:css": "sass --load-path=node_modules --quiet-deps --style=compressed STATIC_SRC/scss/app.scss STATIC_SRC/css/app.css",
    "watch:css": "sass --load-path=node_modules --quiet-deps --watch STATIC_SRC/scss/app.scss:STATIC_SRC/css/app.css"
}

```

```PowerShell
sass --watch src/STATIC_SRC/scss/custom.scss:src/STATIC_SRC/css/custom.css
```

## JavaScript, Images & Other Static Files

All of these files can be found within `STATIC_SRC/`. These files follow a similar build process as Bootstrap, SCSS and CSS. 

- STATIC_SRC/js/ 
- STATIC_SRC/images/
- STATIC_SRC/bootstrap-icons/