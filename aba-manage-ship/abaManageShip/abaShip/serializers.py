from django.contrib.auth.models import Group
from rest_framework import serializers
from rest_framework.serializers import ModelSerializer
from .models import *


class UserSerializer(ModelSerializer):
    choice_group = serializers.IntegerField(max_value=2, min_value=1)

    class Meta:
        model = User
        fields = ['id', 'first_name', 'last_name', 'phone', 'email', 'username', 'password', 'avatar', 'choice_group']
        extra_kwargs = {
            'password': {
                'write_only': True,
                # "validators": [PasswordValidator(language="VN"), ],
                'style': {'input_type': 'password'}
            },
        }

    def create(self, validated_data):
        choice_group = validated_data.pop("choice_group",None)
        user = User(**validated_data)
        user.set_password(validated_data['password'])
        user.save()

        return self.add_group_permission (user=user,choice=choice_group)


    def add_group_permission(self, user, choice):
        if(choice == 1):
            grs = Group.objects.get(name='customer')
        else:
            grs =  Group.objects.get(name='shipper')
        user.groups.add(grs)
        user.save()
        return user


# class IdCard


class StockSerializer(ModelSerializer):
    class Meta:
        model = Stock
        fields = ['id', 'address', 'name_represent_man', 'phone']


class ImageItemSerializer(ModelSerializer):
    class Meta:
        model = ImageItem
        fields = ['id', 'image']


class PostSerializer(ModelSerializer):
    send_stock = StockSerializer(required=True)
    receive_stock = StockSerializer(required=True)
    image_items = ImageItemSerializer(many=True)
    customer = UserSerializer(required=True)

    class Meta:
        model = Post
        fields = ["id", 'customer', "category_product_ship", 'description',
                  "created_date", 'update_date', "send_stock",
                  'receive_stock', 'weight', 'active', 'image_items']


class PostCreateSerializer(ModelSerializer):

    class Meta:
        model = Post
        fields = ["id", "category_product_ship", 'description'
                  , "send_stock",
                  'receive_stock', 'weight',]
        read_only_fields = ["id"]

    
