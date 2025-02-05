from django.contrib import admin
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('admin/', admin.site.urls),
]+static('/static/', document_root=settings.STATIC_ROOT)+static('/media/', document_root=settings.MEDIA_ROOT)
