from django.contrib import admin
from .models import *

# Register your models here.

admin.site.register(User)
admin.site.register(OrderShip)
admin.site.register(OrderShipDetail)
admin.site.register(Post)
admin.site.register(Auction)
admin.site.register(Stock)
admin.site.register(CommentShipper)
admin.site.register(Voucher)
admin.site.register(IDCard)

