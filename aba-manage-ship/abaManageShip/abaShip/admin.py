from django.contrib import admin
from django.contrib.auth.models import Permission
from django.utils.html import mark_safe
from .models import *

# Register your models here.
class PostAdmin(admin.ModelAdmin):

    class Media:
        css= {
            'all': ('/static/css/main.css',)
        }
    list_display = ["description", "weight", "customer"]
    list_filter = ["customer__username", "send_adress", "receive_adress"]
    search_fields = [ "send_adress", "receive_adress", "customer__username"]


class UserAdmin(admin.ModelAdmin):
    list_display = ['first_name', 'last_name','username', 'is_active']
    list_filer = ['first_name', 'last_name','username', 'is_active']
    search_fields = ['first_name', 'last_name','username', 'is_active']
    readonly_fields = ['image_avt']

    def image_avt(self, object):
        return mark_safe("<img src='/static/image/{img_url}' alt='{alt}' width='120px' />".format(img_url=object.avatar.name, alt=object.username))

admin.site.register(User, UserAdmin)
admin.site.register(OrderShip)
admin.site.register(OrderShipDetail)
admin.site.register(Post, PostAdmin)
admin.site.register(Auction)
admin.site.register(Stock)
admin.site.register(CommentShipper)
admin.site.register(Voucher)
admin.site.register(IDCard)
admin.site.register(Permission)

