import datetime

from django.contrib import admin
from django.contrib.auth.models import Permission, Group
from django.contrib.auth.views import redirect_to_login
from django.http import JsonResponse

from django.db.models import Count
from django.template.response import TemplateResponse
from django.urls import path
from django.utils.html import mark_safe
from rest_framework import status

from .models import *
from django import forms
from ckeditor_uploader.widgets import CKEditorUploadingWidget


class ImageItemInlineAdmin(admin.StackedInline):
    model = ImageItem
    fk_name = 'post'

class IDCardInlineAdmin(admin.StackedInline):
    model = IDCard

class OrderIneLineAdmin(admin.StackedInline):
    model = OrderShip


class AuctionInlineAdmin(admin.StackedInline):
    model = Auction
    fk_name = 'post'
#
# class OrderShipDetailInlineAdmin(admin.StackedInline):
#     model = OrderShipDetail


# class PostForm(forms.ModelForm):
#     description = forms.CharField(widget=CKEditorUploadingWidget)
#     class Meta:
#         model = Post
#         fields = '__all__'


class UserAdmin(admin.ModelAdmin):
    list_display = ['first_name', 'last_name','username', 'is_active']
    list_filer = ['first_name', 'last_name','username', 'is_active']
    search_fields = ['first_name', 'last_name','username', 'is_active']
    readonly_fields = ['image_avt']
    inlines = [IDCardInlineAdmin]

    def image_avt(self, object):
        return mark_safe("<img src='/static/image/{img_url}' alt='{alt}' width='120px' />".format(
            img_url=object.avatar.name, alt=object.username))


class IDCardAdmin(admin.ModelAdmin):
    list_display = ['user', 'id_card','mfg_date', 'exp_date']
    list_filter = ['user__username', 'id_card','mfg_date', 'exp_date']
    search_fields = ['user__username', 'id_card','mfg_date', 'exp_date']
    readonly_fields = ['img_front', 'img_back',]

    def img_front(self, object):
        return mark_safe("<img src='/static/image/{img_url}' alt='{alt}' width='90px' />".format(
            img_url=object.image_card_front.name, alt=object.id_card
        ))

    def img_back(self, object):
        return mark_safe("<img src='/static/image/{img_url}' alt='{alt}' width='90px' />".format(
            img_url=object.image_card_back.name, alt=object.id_card
        ))


class CategoryProductShipADmin(admin.ModelAdmin):
    list_display = ['category', 'description']
    list_filter = ['category', 'description']
    search_fields = ['category', 'description']


class PostAdmin(admin.ModelAdmin):

    class Media:
        css= {
            'all': ('/static/css/main.css',)
        }
    list_display = ["id", "customer",
                    "description", "weight", 'send_stock', 'receive_stock']
    list_filter = ["id", "customer",'category_product_ship', "send_stock", "receive_stock"]
    search_fields = ["id", "customer__username",'category_product_ship', "send_stock__address", "receive_stock__address"]
    # form = PostForm
    inlines = [ImageItemInlineAdmin,  ]



class OrderShipAdmin(admin.ModelAdmin):
    list_display = ['auction_win',
                     'active', 'auction_win','shipped_date','status']
    list_filter =  ['auction_win',
                     'active', 'auction_win__shipper','shipped_date','status']
    search_fields =  ['auction_win__shipper_username', 'active','shipped_date','status']
    # inlines = [OrderShipDetailInlineAdmin,]


class AuctionAdmin(admin.ModelAdmin):
    list_display = ['shipper', 'post', 'cost', 'is_win', 'active','created_date']
    list_filter = ['shipper', 'post', 'cost', 'is_win', 'active','created_date']
    search_fields = ['shipper__username', 'post__description', 'cost', 'is_win', 'active','created_date']
    inlines = [OrderIneLineAdmin,]


class ImageItemAdmin(admin.ModelAdmin):
    list_display = ['post', 'image']
    list_filter = ['post', 'image']
    search_fields = ['post__description', 'image']
    readonly_fields = ['item',]

    def item(self, object):
        return mark_safe("<img src='/static/image/{img_url}' alt='{alt}' width='90px' />".format(
            img_url=object.image.url, alt=object.image.url
        ))


class DebtAppAdmin(admin.ModelAdmin):
    list_display = ['order_ship','shipper','deduct','has_payed',]
    list_filter =  ['order_ship','shipper','deduct','has_payed',]
    search_fields = ['shipper__username','deduct__percent','has_payed',]



class DebtShipperAdmin(admin.ModelAdmin):
    list_display = ['order_ship', 'shipper', 'deduct', 'has_payed', ]
    list_filter = ['order_ship', 'shipper', 'deduct', 'has_payed', ]
    search_fields = ['shipper__username', 'deduct__percent', 'has_payed', ]


class DeductAdmin(admin.ModelAdmin):
    list_display = ['percent',]
    list_filter = ['percent',]
    search_fields = ['percent',]


class VoucherAdmin(admin.ModelAdmin):
    list_display = ['name','description', 'discount', 'start_date','end_date']
    list_filter = ['name','description', 'discount', 'start_date','end_date']
    search_fields = ['name','description', 'discount', 'start_date','end_date']


class AbaShipAdminSite(admin.AdminSite):
    site_header = 'Hệ thống quản lý giao hàng AbaShip'

    def get_urls(self):
        return [
            path('aba-ship-stats-post/', self.aba_ship_stats_post),
            path('aba-ship-stats-user/', self.aba_ship_stats_user),
            path('static/',self.api_get_quantity_post_by_month_in_year),
            path('static/user/', self.api_get_quantity_user_by_month_in_year),

        ]  + super().get_urls()

    def aba_ship_stats_post(self,request, **kwargs):
        if self.has_permission(request):
            years = self.get_year_has_post()

            return TemplateResponse(request, 'admin/charts.html',context={'years':years})

        return  redirect_to_login(next='/admin/', login_url='/admin/login/')

    def aba_ship_stats_user(self,request, **kwargs):
        if self.has_permission(request):
            years = self.get_year_has_user()

            return TemplateResponse(request, 'admin/chart_user_stat.html',context={'years':years})

        return  redirect_to_login(next='/admin/', login_url='/admin/login/')


    def api_get_quantity_post_by_month_in_year(self,request):
        try:
            year = int(request.GET.get('year'))
            data =  self.get_quantity_post_by_month_in_year(year=year)
        except:
            return JsonResponse({"error": "Năm không hợp lệ"}, status=status.HTTP_400_BAD_REQUEST)
        return JsonResponse(data, status=status.HTTP_200_OK)

    def get_quantity_post_by_month_in_year(self,year=datetime.datetime.now().year):
        if type(year) is int:
            data = {"months":{}}
            month_post  = [i.month  for i in Post.objects.filter(created_date__year=year).dates('created_date', 'month')]
            print(month_post)
            for i  in month_post:
                data['months'][str(i)] = Post.objects.filter(created_date__year=year, created_date__month=i).count()
            return data
        return {"data": []}


    def api_get_quantity_user_by_month_in_year(self,request):
        try:
            year = int(request.GET.get('year'))
            data =  self.get_quantity_user_by_month_in_year(year=year)
        except:
            return JsonResponse({"error": "Năm không hợp lệ"}, status=status.HTTP_400_BAD_REQUEST)
        return JsonResponse(data, status=status.HTTP_200_OK)

    def get_quantity_user_by_month_in_year(self,year=datetime.datetime.now().year):
        if type(year) is int:
            data = {"months":{}}
            month_user  = [i.month  for i in User.objects.filter(date_joined__year=year).dates('date_joined', 'month')]
            print(month_user)
            for i  in month_user:
                data['months'][str(i)] = User.objects.filter(date_joined__year=year, date_joined__month=i).count()
            return data
        return {"data": []}


    def has_permission(self, request):
        return request.user.is_active and request.user.is_superuser

    def get_year_has_post(self):
        return [i.year for i in Post.objects.dates("created_date", "year","DESC")]

    def get_year_has_user(self):
        return [i.year for i in User.objects.dates("date_joined", "year", "DESC")]

admin_site  =  AbaShipAdminSite(name='myadmin')





# admin.site.unregister(User)
admin_site.register(User, UserAdmin)
admin_site.register(CategoryProductShip,CategoryProductShipADmin)
admin_site.register(OrderShip, OrderShipAdmin)
# admin_site.register(OrderShipDetail)
admin_site.register(Post, PostAdmin)
admin_site.register(ImageItem, ImageItemAdmin)
admin_site.register(Auction, AuctionAdmin)
admin_site.register(Stock)
admin_site.register(Rate)
admin_site.register(Voucher)
admin_site.register(IDCard,IDCardAdmin)
admin_site.register(Deduct)
admin_site.register(DebtApp)
admin_site.register(DebtShipper)
admin_site.register(Permission)
admin_site.register(Group)
