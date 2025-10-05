# Django Views


## A Simple View Overview
This function that returns an HttpResponse.

```
from django.contrib import admin
from django.urls import path
from django.http import HttpResponse # return a Http response

def my_func(request)
    return HttpResponse('Hello World')

urlpatterns = [
        path('admin/', admin.site.urls),
        path('hello', my_func), # don't call the function here
]
```