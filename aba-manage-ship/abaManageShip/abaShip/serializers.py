from django.contrib.auth.models import Group
from rest_framework import serializers

from rest_framework.exceptions import ValidationError
from rest_framework.fields import ImageField
from rest_framework.serializers import ModelSerializer, Serializer, CharField, IntegerField
from .models import *
from django.db import IntegrityError



class MomoPaySerializer(Serializer):
    auction_id = IntegerField()
    user_id = IntegerField()

class BaseUserSerializer(ModelSerializer):
    avatar = ImageField(required=True, error_messages={'required': 'Lỗi upload avatar'})

    class Meta:
        model = User
        fields = ['id', 'first_name', 'last_name', 'avatar', 'username']
        # read_only_fields = ["date_joined", 'id', 'username']


class ShipperSerializer(BaseUserSerializer):
    class Meta:
        model = BaseUserSerializer.Meta.model
        fields = BaseUserSerializer.Meta.fields + ['date_of_birth', 'gender', 'phone', 'address', 'email', ]
        read_only_fields = ["date_joined", 'id', 'username']


class UserSerializer(BaseUserSerializer):
    class Meta:
        model = BaseUserSerializer.Meta.model

        fields = BaseUserSerializer.Meta.fields + ['phone', 'email', 'avatar', 'gender', 'address',
                                                   'date_of_birth', 'groups']
        read_only_fields = ["date_joined", 'id', 'username', 'groups']


class UserRegisterSerializer(ModelSerializer):
    choice_group = serializers.IntegerField(max_value=2, min_value=1)

    class Meta:
        model = User
        fields =  ['id', 'first_name', 'last_name', 'avatar', 'username','phone', 'email','password', 'choice_group', 'gender', 'address', 'date_of_birth']
        extra_kwargs = {
            'password': {
                'write_only': True,
                # "validators": [PasswordValidator(language="VN"), ],
                'style': {'input_type': 'password'}
            },
        }

    def create(self, validated_data):

        choice_group = validated_data.pop("choice_group", None)
        print("chuối: ", validated_data)
        user = User(**validated_data)
        user.set_password(validated_data['password'])
        user.save()

        return self.add_group_permission(user=user, choice=str(choice_group))

    def add_group_permission(self, user, choice):
        if choice == '1':
            grs = Group.objects.get(name='customer')
        elif choice == '2':
            grs = Group.objects.get(name='shipper')
        user.groups.add(grs)
        user.save()
        return user


# class IdCard


class StockSerializer(ModelSerializer):
    customer = UserSerializer(required=True)

    class Meta:
        model = Stock
        fields = ['id', 'customer', 'address', 'name_represent_man', 'phone']
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


class PostSerializer(ModelSerializer):
    send_stock = StockSerializer(required=True)
    receive_stock = StockSerializer(required=True)
    image_items = ImageItemSerializer(many=True, required=True)
    customer = UserSerializer(required=True)

    class Meta:
        model = Post
        fields = ["id", 'customer', "category_product_ship", 'description',
                  "created_date", 'update_date', "send_stock",
                  'receive_stock', 'weight', 'active', 'image_items', 'is_finish']
        read_only_fields = ['id', 'customer', 'active', "created_date", 'update_date', ]


class PostCreateSerializer(ModelSerializer):
    class Meta:
        model = Post
        fields = ["id", "category_product_ship", 'description',
                  "send_stock", 'receive_stock', 'weight', ]
        read_only_fields = ["id"]


class AuctionCreateSerializer(ModelSerializer):
    class Meta:
        model = Auction
        fields = ['cost', 'post', 'shipper']
        # read_only_fields = ['id', 'post', 'shipper', 'created_date', 'update_date', 'is_win', 'active']


class AuctionSerializer(AuctionCreateSerializer):
    shipper = BaseUserSerializer(required=True)

    class Meta:
        model = AuctionCreateSerializer.Meta.model
        fields = AuctionCreateSerializer.Meta.fields + ['id', 'active', 'created_date', 'update_date', 'is_win']


class AutionDetailPostSerializer(AuctionSerializer):
    shipper = UserSerializer(required=True)
    post = PostSerializer(required=True)

    class Meta:
        model = AuctionSerializer.Meta.model
        fields = AuctionSerializer.Meta.fields


class OrderCreateSerializer(ModelSerializer):
    def to_representation(self, instance):
        rep = super().to_representation(instance)
        rep['status'] = OrderShip.STATUS[rep.get('status')][1] or None
        rep['pay_method'] = OrderShip.PAY_METHOD[rep.get('pay_method')][1] or None
        return rep

    class Meta:
        model = OrderShip
        fields = ['auction_win', 'pay_method', 'voucher', 'active', 'shipped_date', 'status', ]



class OrderSerializer(OrderCreateSerializer):
    auction_win = AutionDetailPostSerializer(required=True)



    class Meta:
        model = OrderCreateSerializer.Meta.model
        fields =  OrderCreateSerializer.Meta.fields
        read_only_fields = ['auction_win', 'active', 'shipped_date', ]


class VoucherSerializer(ModelSerializer):
    class Meta:
        model = Voucher
        fields = "__all__"

class RatingCreateSerializer(ModelSerializer):
    class Meta:
        model = Rate
        fields = "__all__"
        read_only_fields = ['id', 'customer', 'shipper']

class RatingSerializer(RatingCreateSerializer):
    customer = BaseUserSerializer(required=True)
    shipper = BaseUserSerializer(required=True)

    class Meta:
        model =  RatingCreateSerializer.Meta.model
        fields = RatingCreateSerializer.Meta.fields
        read_only_fields = ['id', 'customer', 'shipper']

