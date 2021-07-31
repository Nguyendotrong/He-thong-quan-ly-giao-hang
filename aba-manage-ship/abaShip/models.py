from enum import Enum

from django.db import models

# Create your models here.
from django.contrib.auth.models import AbstractUser


class User (AbstractUser):
    avatar = models.ImageField(upload_to='avatar/%Y%m')

class IDCard(models.Model):
    user = models.OneToOneField(User,on_delete=models.CASCADE,primary_key=True)
    id = models.CharField(max_length=12,null=False)
    image_card = models.ImageField(upload_to='idcard/image/%Y/%m')
    mfg_date = models.DateTimeField(null=False)
    exp_date = models.DateTimeField(null=False)

class PayMethod (Enum):
    ZALO = 'ZALO'
    MOMO = 'MOMO'
    TIENMAT = 'TIENMAT'

class  base(models.Model):

    created_date = models.DateTimeField(auto_now_add=True)
    update_date = models.DateTimeField(auto_now=True)
    class  Meta:
        abstract = True

class Voucher(base):
    name =  models.CharField(max_length=100)
    decription = models.TextField(default= None)
    discount = models.FloatField()


class OrderShip(models.Model):

    created_date = models.DateTimeField(auto_now_add=True)
    update_date = models.DateTimeField(auto_now=True)
    shipped_date = models.DateTimeField()
    receive_adress = models.TextField(null=False)
    send_adress = models.TextField(null= True)
    active = models.BooleanField(default=True)
    customer = models.ForeignKey(User, related_name='cus_orders', on_delete=models.PROTECT)
    shipper = models.ForeignKey(User, related_name='shipper_orders', on_delete=models.PROTECT)
    post = models.OneToOneField('Post', on_delete=models.CASCADE)
    status = models.CharField(choices=[(tag, tag.value) for tag in 'StatusShip'])


class StatusShip (Enum):
    SHIPPED  = 'shipped'
    SHIPPING = 'shipping'
    NOTYETSHIPPED ='not yet shipped'


class OrderShipDetail (models.Model):
    orderShip = models.OneToOneField('Post',on_delete= models.CASCADE)
    pay_method = models.CharField(max_length=20,
                                  choices=[(tag,tag.value) for tag in PayMethod])
    voucher = models.ForeignKey(Voucher,on_delete=models.PROTECT)



class Post(models.Model):
    created_date = models.DateTimeField(auto_now_add=True)
    update_date = models.DateTimeField(auto_now=True)
    customer = models.ForeignKey(User, on_delete=models.CASCADE)
    active = models.BooleanField(default=True)


class Post_detail(models.Model):
    post = models.OneToOneField(Post, on_delete=models.CASCADE, primary_key=True)
    description = models.TextField(null=False)
    image = models.ImageField(upload_to='post/%Y/%m')
    receive_adress = models.TextField(null=False)
    send_adress = models.TextField(null=True)
    weight = models.FloatField(null=True)

class Auction(models.Model):
    post = models.ForeignKey(Post, on_delete=models.CASCADE)
    shipper = models.ForeignKey(User, on_delete=models.CASCADE)
    price = models.DecimalField(null=False)
    created_date  = models.DateTimeField(auto_now_add=True)
    update_date  = models.DateTimeField(auto_now=True)
    is_win = models.BooleanField(default=False)
    Active =  models.BooleanField(default=True)


class Comment (models.Model):
    customer = models.ForeignKey(User, on_delete= models.PROTECT)
    shipper = models.ForeignKey(User, on_delete=models.PROTECT)
    content = models.TextField()

    def __str__(self):
        return self.customer.first_name + self.shipper.first_name + self.content


class Rate (models.Model):
    customer = models.ForeignKey(User, on_delete=models.PROTECT)
    shipper = models.ForeignKey(User, on_delete=models.PROTECT)

    class Suit (models.IntegerChoices):
        ONE  = 1
        TWO = 2
        THREE = 3
        FOUR = 4
        five = 5

    rate = models.IntegerChoices(choice=Suit.choices)

    def __str__(self):
        return self.customer.first_name + self.shipper.first_name + str(self.rate)







