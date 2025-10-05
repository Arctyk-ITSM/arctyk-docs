# Django Apps

## Create a Django app

1. Create a new app using `startapp`
2. Add it to the settings via `settings.py`
3. Create a **URL**
4. Link it to a **view**
5. Return a **template**
6. Make it dynamic with **context**
7. Use data from a **model**
8. Add some **static** files

## Create a URL
1. Create a new file in the new app folder called `urls.py`
2. Use the URL pattern code block below to define the url:
    ```
    from django.urls import path
    from . import views 
    
    app_name = 'yourappname'

    urlpatterns = [
        path('', views.index, name='index')
    ]
    ```
3. Go back to project level `urls.py` and add the path from your app.

    ```
    from django.contrib import admin
    from django.urls import path, include  # add 'include' here
    

    urlpatterns = [
        path('admin/, admin.site.urls),  # existing code
        path('', include('yourappname.urls')) # add this line
    ]
    ```
4. Next we link the app to a **View**. Go to `views.py` and add the following function:

    ```
    from django.http import HttpResonse


    def index(request):
        return HttpResponse("Hello, world")
    ```
5. Return a template.
    - Inside of 'yourappname', create a new folder called `templates`.
    - In the `templates` folder, create an empty `index.html`.
    - Update yours `views.py` to render the new template file.

        ```
        from django.shortcuts import render


        def index(request):
            return render(request, 'index.html')
        ```
    - **Render** is a django "shortcut" that:
        1. Retrieves the template
        2. Renders it to an HTML file based on the data you pass in it
        3. Returns as an HttpResonse

6. Make your app dynamic by using **context**. For the example below, we will add a simple visitor counter. 
    1. Update `views.py` and add the following function:
        ```
        from random import randint
        from django.shortcuts import render


        def index(request):
            context = {
                "num_visits": randint(1, 10)
            }
            return render(request, "index.html", context=context)
        ```
    2. Now we need to update `index.html` to use the `num_visits` variable.

        ```
        <html>
        <head>
            <title>Sample App Views</title>
        </head>
        <body>
            <h1>Hello world</h1</h1>
            <p>This page has been visited {{ num_visits }} time{{ num_visits|pluralize }}.</p>
        </body>
        </html>
        ```

    - **The Django Template Language**
       - The **{{ var }}** syntax is a variable that gets evaluated (from the context) and is replaced when the template is rendered.
        - The **{{ var|filter }}** syntax is a filter
        - The pluralize filter returns an "s" if the variable is greater than 1.

7. Use data from a **model**. Models allow you to use data and information from the database.

    - Open `models.py` in 'yourappname'. Create a new model using the sample below to store a visit to your site.

        ```
        from django.db import models


        class Visits(models.Model):
            count = models.IntergerField(default=0)  # adds new column in database
        ```
    2. After making a change to a model, the database needs to be updated. In Django, we do that by creating a migration file. 

        From your terminal, run the the migration commands. 

       `python manage.py makemirgrations`

       You should see the output in your terminal:

       ```
       Migrations for 'visits':
        visits/migrations/0001_initial.py
            - Create model Visits
        ```
        The output creates a new file called `0001_initial.py` and a folder called `migrations`. If you examine the file contents, you will see the actual SQL commands.

    3. Now that we have created the migration file, we apply apply the migration.

        `python manage.py migrate`

        