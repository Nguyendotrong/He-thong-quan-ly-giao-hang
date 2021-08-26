from rest_framework.serializers import ModelSerializer
from .models import *


class UserSerializer(ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'first_name', 'last_name', 'phone', 'email', 'username','password', 'avatar',]
        extra_kwargs ={
            'password': {
                'write_only': True,
                # "validators": [PasswordValidator(language="VN"), ],
                'style': {'input_type': 'password'}
            },
        }

    def create(self, validated_data):
        user = User(**validated_data)
        user.set_password(validated_data['password'])
        user.save()

        return user


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
    customer = UserSerializer(required=True)
    class Meta:

        model = Post
        fields = ["id", 'customer', "category_product_ship",'description',
                  "created_date", 'update_date', "send_stock",
                  'receive_stock', 'weight', 'active', 'image_items']





