from django.contrib import admin
from django.contrib.auth.models import Permission, Group

from django.db.models import Count
from django.template.response import TemplateResponse
from django.urls import path
from django.utils.html import mark_safe
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

class OrderShipDetailInlineAdmin(admin.StackedInline):
    model = OrderShipDetail


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
    inlines = [OrderShipDetailInlineAdmin,]


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
            path('aba-ship-stats/', self.aba_ship_stats)
        ]  + super().get_urls()

    def aba_ship_stats(self,request):
        post_count = Post.objects.count()
        # stats = CategoryProductShip.objects.annotate(post_count=Count('post'))\
        #     .values('id','category_product_ship', 'post_count')
        re = CategoryProductShip.objects.raw('''
            SELECT abaship_categoryproductship.id,category, COUNT(abaship_post.id) as aquantity
            from  abaship_post inner join abaship_post_category_product_ship inner join abaship_categoryproductship
            on abaship_post.id = abaship_post_category_product_ship.post_id
            and abaship_categoryproductship.id = abaship_post_category_product_ship.categoryproductship_id
            where abaship_post.id in (select id from abaship_post inner join abaship_ordership)
            group by category
        ''')

        return TemplateResponse(request, 'admin/aba-ship-stats.html',{
            'post_count': post_count,
            're':re
        })

admin_site  =  AbaShipAdminSite(name='myadmin')





# admin.site.unregister(User)
admin_site.register(User, UserAdmin)
admin_site.register(CategoryProductShip,CategoryProductShipADmin)
admin_site.register(OrderShip, OrderShipAdmin)
admin_site.register(OrderShipDetail)
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
