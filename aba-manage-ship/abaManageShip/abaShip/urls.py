from django.contrib import admin
from django.urls import path, re_path, include
from . import views
from .admin import admin_site
from rest_framework.routers import DefaultRouter


router = DefaultRouter()
router.register('posts', views.PostViewSet)
router.register('users',views.UserViewSet)
router.register('stocks',views.StockViewSet)

urlpatterns = [

    # path('', views.Index.as_view()),
    path('', include(router.urls)),
    path('admin/', admin_site.urls),

    path('o/', include('oauth2_provider.urls',
    namespace='oauth2_provider')),
]

