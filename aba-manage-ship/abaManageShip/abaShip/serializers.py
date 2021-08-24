from rest_framework.serializers import ModelSerializer
from .models import *


# class IdCard


class StockSerializer(ModelSerializer):
    class Meta:
        model= Stock
        fields =['address', 'name_represent_man','phone']


class ImageItemSerializer(ModelSerializer):
    class Meta:
        model = ImageItem
        fields =  ['id', 'image']


class PostSerializer(ModelSerializer):
    send_stock = StockSerializer(required=True)
    receive_stock = StockSerializer(required=True)
    image_items = ImageItemSerializer(many=True)
    class Meta:

        model = Post
        fields = ["id", 'customer', "category_product_ship",'description',
                  "created_date", 'update_date', "send_stock",
                  'receive_stock', 'weight', 'active', 'image_items']


