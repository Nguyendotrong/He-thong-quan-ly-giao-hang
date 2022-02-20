from django.contrib import admin
from django.urls import path, re_path, include
from rest_framework import permissions

from . import views
from .admin import admin_site
from rest_framework.routers import DefaultRouter
from drf_yasg.views import get_schema_view
from drf_yasg import openapi


router = DefaultRouter()
router.register('posts', views.PostViewSet, 'posts')
router.register('users',views.UserViewSet)
router.register('stocks',views.StockViewSet)
router.register('image-item',views.ImageItemViewSet)
router.register('shippers',views.ShipperViewSet)
router.register('auctions',views.AuctionViewSet)
router.register('orders',views.OrderShipViewSet)
router.register('vouchers',views.VoucherViewSet)
router.register('rates',views.RatingViewSet)
router.register('payment',views.MomoPay,basename='payment')
# router.register('order-detail',views.OrderDetailViewSet)


schema_view = get_schema_view(
    openapi.Info(
        title="Abaship  API",
        default_version='v1',
        description="APIs for Abaship app",
        contact=openapi.Contact(email="nguyendotrong.it@gmail.com"),
        license=openapi.License(name="Nguyễn Đỗ Trọng@2021"),
    ),
    public=True,
    permission_classes=(permissions.AllowAny,),
)

urlpatterns = [

    re_path(r'^swagger(?P<format>\.json|\.yaml)$', schema_view.without_ui(cache_timeout=0),name='schema-json'),
    re_path(r'^swagger/$', schema_view.with_ui('swagger', cache_timeout=0),name='schema-swagger-ui'),
    re_path(r'^redoc/$',schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),

    # path('', views.Index.as_view()),
    path('', include(router.urls)),
    path('oauth2-info/', views.OauthInfo.as_view()),
    path('admin/', admin_site.urls),

    path('o/', include('oauth2_provider.urls',
    namespace='oauth2_provider')),
]

