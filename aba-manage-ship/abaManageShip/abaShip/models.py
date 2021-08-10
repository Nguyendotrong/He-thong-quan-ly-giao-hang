from enum import Enum

from django.core.validators import MaxValueValidator, MinValueValidator
from django.db import models

# Create your models here.
from django.contrib.auth.models import AbstractUser


class User (AbstractUser):
    avatar = models.ImageField(upload_to='avatar/%Y%m')
    phone = models.CharField(max_length=10,null=False)

    def __str__(self):
        return "name: {} {}".format(self.first_name, self.last_name)

class Stock(models.Model):
    address = models.CharField(max_length=150,null=False)
    name_represent_man = models.CharField(max_length=100, null=False)
    phone = models.CharField(max_length=10, null=False)

class IDCard(models.Model):
    user = models.OneToOneField(User,on_delete=models.CASCADE,primary_key=True)
    id_card = models.CharField(max_length=12,null=False, unique=True)
    image_card = models.ImageField(upload_to='idcardimage/%Y/%m')
    mfg_date = models.DateTimeField(null=False)
    exp_date = models.DateTimeField(null=False)

    def __str__(self):
        return "Id card: {}".format(self.id_card)

class PayMethod (Enum):
    ZALO = 'ZALO'
    MOMO = 'MOMO'
    TIENMAT = 'TIENMAT'

class  Base(models.Model):

    created_date = models.DateTimeField(auto_now_add=True)
    update_date = models.DateTimeField(auto_now=True)
    class  Meta:
        abstract = True
        # ordering = ['-id']


class Voucher(Base):
    name =  models.CharField(max_length=200, null=False)
    decription = models.TextField(null=False, blank=False)
    discount = models.FloatField(null=False)
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()

    def __str__(self):
        return "name: {},\ndiscount: {}".format(self.name,self.discount)

class StatusShip (Enum):
    SHIPPED  = 'shipped'
    SHIPPING = 'shipping'
    NOTYETSHIPPED ='not yet shipped'

class OrderShip(Base):

    post = models.OneToOneField('Post', on_delete=models.CASCADE, primary_key=True)

    receive_stock = models.ForeignKey(Stock, related_name='orders_ship_receive',
                                      on_delete=models.PROTECT, null=False)
    send_stock = models.ForeignKey(Stock, related_name='orders_ship_send',
                                   on_delete=models.PROTECT,null=False)
    active = models.BooleanField(default=True)
    shipper = models.ForeignKey(User, related_name='shipper_orders', on_delete=models.PROTECT)
    shipped_date = models.DateTimeField(default=None, null=True)
    status = models.CharField(max_length=30,choices=[(tag, tag.value) for tag in StatusShip ])

    def __str__(self):
        return "customer: {},\nshipper: {},\nstatus: {},\ncreated date: {}".format(
            self.post.customer.first_name + " " + self.post.customer.last_name,
            self.shipper.first_name + " " + self.shipper.last_name ,
            self.created_date)


class OrderShipDetail (models.Model):
    orderShip = models.OneToOneField('Post',on_delete= models.CASCADE, primary_key=True)
    pay_method = models.CharField(max_length=20,
                                  choices=[(tag, tag.value) for tag in PayMethod])

    voucher = models.ForeignKey(Voucher,on_delete=models.PROTECT)

    def __str__(self):
        return "Pay medthod: {},".format(self.pay_method)


class Post(Base):

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

class Auction(Base):

    class Meta:
        unique_together = ['post','shipper']
        ordering = ['post']

    post = models.ForeignKey(Post,related_name="autions", on_delete=models.CASCADE)
    shipper = models.ForeignKey(User, related_name='autions', on_delete=models.CASCADE)
    price = models.DecimalField(max_digits=12, decimal_places=0, null=False)
    is_win = models.BooleanField(default=False)
    Active =  models.BooleanField(default=True)

    def __str__(self):
        return "shipper: {},\nprice: {}".format(self.shipper.first_name, self.price)


class CommentShipper  (Base):

    order_ship = models.OneToOneField(OrderShip, on_delete= models.PROTECT, primary_key=True)
    content = models.TextField(null=False, blank=False)
    rate = models.IntegerField(default=1, null=False,
                               validators=[
                                   MaxValueValidator(
                                   limit_value=5, message="Đánh giá nhỏ hơn hoặc bằng 5"),
                                    MinValueValidator(
                                               limit_value=1, message="đánh giá từ 1 đến 5")
                               ])

    def __str__(self):
        return "Customer: {},\nshipper: {},\norder ship: {},\nComment: {},\nrate: {},\n".format(
            self.order_ship.customer.first_name + " " + self.order_ship.customer.last_name,
            self.order_ship.shipper. fist_name + " " + self.order_ship.shipper.last_name,
            self.order_ship,
            self.content,
            self.rate
        )


class Deduct(Base):

    percent = models.FloatField(
        validators=[MaxValueValidator(30.0), MinValueValidator(0.0)
                    ])

    def __str__(self):
        return "percent: {}".format(self.percent)



class DebtShipper(models.Model):
    order_ship = models.OneToOneField(OrderShip,on_delete=models.PROTECT)
    shipper = models.ForeignKey(User, on_delete=models.PROTECT)
    deduct = models.ForeignKey(Deduct, on_delete=models.PROTECT)
    has_payed = models.BooleanField(default=False)



class DetpApp(models.Model):
    order_ship = models.OneToOneField(OrderShip, on_delete=models.PROTECT)
    shipper = models.ForeignKey(User, on_delete=models.PROTECT)
    deduct = models.ForeignKey(Deduct, on_delete=models.PROTECT)
    has_payed = models.BooleanField(default=False)
    pay_method = models.CharField(max_length=20,
                                  choices=[(tag, tag.value) for tag in PayMethod])



