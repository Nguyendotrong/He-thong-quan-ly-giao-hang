from enum import Enum

from django.db import models

# Create your models here.
from django.contrib.auth.models import AbstractUser


class User (AbstractUser):
    avatar = models.ImageField(upload_to='avatar/%Y%m')

    def __str__(self):
        return "name: {} {}".format(self.first_name, self.last_name)

class IDCard(models.Model):
    user = models.OneToOneField(User,on_delete=models.CASCADE,primary_key=True)
    id_card = models.CharField(max_length=12,null=False)
    image_card = models.ImageField(upload_to='idcardimage/%Y/%m')
    mfg_date = models.DateTimeField(null=False)
    exp_date = models.DateTimeField(null=False)

    def __str__(self):
        return "Id card: {}".format(self.id_card)

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
    def __str__(self):
        return "name: {},\ndiscount: {}".format(self.name,self.discount)


class OrderShip(base):

    shipped_date = models.DateTimeField()
    receive_adress = models.TextField(null=False)
    send_adress = models.TextField(null= True)
    active = models.BooleanField(default=True)
    customer = models.ForeignKey(User, related_name='cus_orders', on_delete=models.PROTECT)
    shipper = models.ForeignKey(User, related_name='shipper_orders', on_delete=models.PROTECT)
    post = models.OneToOneField('Post', on_delete=models.CASCADE)
    status = models.CharField(choices=[(tag, tag.value) for tag in 'StatusShip'])

    def __str__(self):
        return "customer: {},\nshipper: {},\nstatus: {},\ncreated date: {}".format(
            self.customer.fisrt_name, self.shipper.first_name, self.created_date)


class StatusShip (Enum):
    SHIPPED  = 'shipped'
    SHIPPING = 'shipping'
    NOTYETSHIPPED ='not yet shipped'


class OrderShipDetail (models.Model):
    orderShip = models.OneToOneField('Post',on_delete= models.CASCADE, primary_key=True)
    pay_method = models.CharField(max_length=20,
                                  choices=[(tag,tag.value) for tag in PayMethod])
    voucher = models.ForeignKey(Voucher,on_delete=models.PROTECT)

    def __str__(self):
        return "Pay medthod: {},".format(self.pay_method)



class Post(models.Model):
    created_date = models.DateTimeField(auto_now_add=True)
    update_date = models.DateTimeField(auto_now=True)
    customer = models.ForeignKey(User, on_delete=models.CASCADE)
    active = models.BooleanField(default=True)
    description = models.TextField(null=False)
    image = models.ImageField(upload_to='productimage/%Y/%m')
    receive_adress = models.TextField(null=False)
    send_adress = models.TextField(null=True)
    weight = models.FloatField(null=True)

    def __str__(self):
        return "Customer: {} {},\nCreated date: {}".format(self.customer.first_name,
                                                           self.customer.last_name, self.created_date)


class Auction(models.Model):
    post = models.ForeignKey(Post, on_delete=models.CASCADE)
    shipper = models.ForeignKey(User, on_delete=models.CASCADE)
    price = models.DecimalField(null=False)
    created_date  = models.DateTimeField(auto_now_add=True)
    update_date  = models.DateTimeField(auto_now=True)
    is_win = models.BooleanField(default=False)
    Active =  models.BooleanField(default=True)

    def __str__(self):
        return "shipper: {},\nprice: {}".format(self.shipper.first_name, self.price)


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
        ONE = 1
        TWO = 2
        THREE = 3
        FOUR = 4
        five = 5

    rate = models.IntegerChoices(choice=Suit.choices)

    def __str__(self):
        return self.customer.first_name + self.shipper.first_name + str(self.rate)







