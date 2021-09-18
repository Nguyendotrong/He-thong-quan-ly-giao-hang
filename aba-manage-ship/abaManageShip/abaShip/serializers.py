from django.contrib.auth.models import Group
from rest_framework import serializers
from rest_framework.fields import ImageField
from rest_framework.serializers import ModelSerializer
from .models import *


class ShipperSerializer(ModelSerializer):
    avatar = ImageField(required=True, error_messages={'required': 'Avatar không được để trống'})
    class Meta:
        model =User
        fields = ['id','first_name', 'last_name','avatar','date_of_birth', 'gender', 'phone', 'address', 'email',]
        read_only_fields = ["date_joined", 'id', 'username']

class UserSerializer(ModelSerializer):
    avatar = ImageField(required=True, error_messages={'required': 'Avatar không được để trống'})

    class Meta:
        model = User

        fields = ['id', 'username', 'first_name', 'last_name', 'phone', 'email',
                   'avatar', 'gender', 'address',
                  'date_of_birth','groups']
        read_only_fields = ["date_joined", 'id','username','groups']



class UserRegisterSerializer(ModelSerializer):
    choice_group = serializers.IntegerField(max_value=2, min_value=1)
    avatar =  ImageField(required=True, error_messages={'required': 'Avatar không được để trống'})
    class Meta:
        model = User
        fields = ['id', 'first_name', 'last_name', 'phone', 'email',
                  'username', 'password', 'avatar', 'choice_group',
                  'gender', 'address', 'date_of_birth']
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
    customer = UserSerializer(required=True)
    class Meta:
        model = Stock
        fields = ['id', 'customer','address', 'name_represent_man', 'phone']
        read_only_fields = ["id"]


class StockCreateSerializer(ModelSerializer):

    class Meta:
        model = Stock
        fields = ['address', 'name_represent_man', 'phone']
        read_only_fields = ["id"]

    # def create(self, validated_data):
    #     stock = Stock(**validated_data)
    #     stock.customer = self.request.user
    #     stock.save()
    #     return stock


class ImageItemSerializer(ModelSerializer):
    image = ImageField(required=True, error_messages={'required': 'Hình ảnh không được để trống'})

    class Meta:
        model = ImageItem
        fields = ['id', 'image', 'post']

class ImageItemCreatSerializer(ModelSerializer):

    image = ImageField(required=True, error_messages={'required': 'Hình ảnh không được để trống'})
    class Meta:
        model = ImageItem
        fields = ['id', 'image', 'post']

class AuctionSerializer(ModelSerializer):
    shipper = ShipperSerializer(required=True)

    class Meta:
        model =  Auction
        fields= ['id', 'post','shipper', 'cost','is_win','active', 'created_date', 'update_date']
        read_only_fields = ['id', 'post','shipper', 'created_date', 'update_date','is_win','active']

class AuctionCreateSerializer(ModelSerializer):
    class Meta:
        model =  Auction
        fields= ['cost','post', 'shipper']

class PostSerializer(ModelSerializer):
    send_stock = StockSerializer(required=True)
    receive_stock = StockSerializer(required=True)
    image_items = ImageItemSerializer(many=True)
    customer = UserSerializer(required=True)


    class Meta:
        model = Post
        fields = ["id", 'customer', "category_product_ship", 'description',
                  "created_date", 'update_date', "send_stock",
                  'receive_stock', 'weight', 'active', 'image_items', 'auctions']
        read_only_fields =  ['id', 'customer']


class PostCreateSerializer(ModelSerializer):

    class Meta:
        model = Post
        fields = ["id", "category_product_ship", 'description',
                  "send_stock", 'receive_stock', 'weight',]
        read_only_fields = ["id"]


