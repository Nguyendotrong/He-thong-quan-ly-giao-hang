from enum import Enum
from django.contrib.auth.models import AbstractUser
from django.core.validators import MaxValueValidator, MinValueValidator
from django.db import models
from  ckeditor.fields import RichTextField

# Create your models here.



class User (AbstractUser):
    avatar = models.ImageField(upload_to='avatar/%Y/%m/')
    phone = models.CharField(max_length=10,null=False)
    first_name = models.CharField(max_length=50, null=False, blank=False)
    last_name = models.CharField(max_length=50, null=False, blank=False)

    def __str__(self):
        return "name: {}".format(self.username)

class Stock(models.Model):
    address = models.CharField(max_length=150,null=False)
    name_represent_man = models.CharField(max_length=100, null=False)
    phone = models.CharField(max_length=10, null=False)

    def __str__(self):
        return "Address: {},\n Represent man: {},\nPhone: {}".format(
            self.address,self.name_represent_man, self.phone)

class IDCard(models.Model):
    user = models.OneToOneField(User,on_delete=models.CASCADE,primary_key=True)
    id_card = models.CharField(max_length=12,null=False, unique=True)
    image_card_front = models.ImageField(upload_to='idcard/%Y/%m/', default=None)
    image_card_back = models.ImageField(upload_to='idcard/%Y/%m/', default=None)
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
    description = models.TextField(null=False, blank=False)
    discount = models.FloatField(null=False)
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()

    def __str__(self):
        return "name: {},\ndiscount: {}".format(self.name,self.discount)

class StatusShip (Enum):
    NOTYETSHIPPED = 'not yet shipped'
    SHIPPING = 'shipping'
    SHIPPED = 'shipped'

class OrderShip(Base):

    auction_win = models.OneToOneField('Auction',related_name='order_ship', on_delete=models.PROTECT,primary_key=True)
    active = models.BooleanField(default=True)
    shipped_date = models.DateTimeField(null=True, blank=True)
    status = models.CharField(max_length=30,choices=[(tag.name, tag.value) for tag in StatusShip ],
                              default=StatusShip.NOTYETSHIPPED)

    def __str__(self):
        return "customer: {},\nshipper: {},\nstatus: {},\ncreated date: {}".format(
            self.auction_win.post.customer.username + " " + self.auction_win.post.customer.last_name,
            self.auction_win.shipper.first_name + " " + self.auction_win.shipper.last_name ,
            self.status,
            self.created_date)


class OrderShipDetail (models.Model):
    orderShip = models.OneToOneField(OrderShip,on_delete= models.CASCADE, primary_key=True)
    pay_method = models.CharField(max_length=20,
                                  choices=[(tag.name, tag.value) for tag in PayMethod])

    voucher = models.ForeignKey(Voucher,on_delete=models.PROTECT)

    def __str__(self):
        return "Pay medthod: {},".format(self.pay_method)


class CategoryProductShip(models.Model):
    category = models.CharField(max_length=100, null=False)
    description = models.TextField()

    def __str__(self):
        return "Category: {},\nDescription: {}".format(self.category, self.description)


class Post(Base):

    customer = models.ForeignKey(User, on_delete=models.CASCADE)
    active = models.BooleanField(default=True)
    category_product_ship = models.ManyToManyField(CategoryProductShip,related_name='posts', null=True, blank=True)
    send_stock = models.ForeignKey(Stock, related_name='posts_ship_send',
                                   on_delete=models.PROTECT, null=False, default=None)
    receive_stock = models.ForeignKey(Stock, related_name='posts_ship_receive',
                                      on_delete=models.PROTECT, null=False, default=None)
    description = RichTextField(null=False)
    # image = models.ImageField(upload_to='item/%Y/%m')
    weight = models.FloatField(null=True)

    def __str__(self):
        return "Customer: {} {},\nCategory product: {},\nCreated date: {}".format(
            self.customer.first_name, self.customer.last_name,self.category_product_ship, self.created_date)

class ImageItem(models.Model):
    post  = models.ForeignKey(Post,related_name='image_items', on_delete=models.CASCADE)
    image = models.ImageField(upload_to='item/%Y/%m/')

    def __str__(self):
        return "post: {}".format(self.post.weight)


class Auction(Base):

    class Meta:
        unique_together = ['post','shipper']
        ordering = ['post']

    post = models.ForeignKey(Post,related_name="autions", on_delete=models.CASCADE)
    shipper = models.ForeignKey(User, related_name='autions', on_delete=models.CASCADE)
    cost = models.DecimalField(max_digits=14, decimal_places=2, null=False)
    is_win = models.BooleanField(default=False)
    active =  models.BooleanField(default=True)

    def __str__(self):
        return "shipper: {},\nprice: {}".format(self.shipper.first_name, self.cost)


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
        validators=[MaxValueValidator(40.0), MinValueValidator(0.0)
                    ])

    def __str__(self):
        return "percent: {}".format(self.percent)



class DebtShipper(models.Model):
    order_ship = models.OneToOneField(OrderShip,on_delete=models.PROTECT)
    shipper = models.ForeignKey(User, on_delete=models.PROTECT)
    deduct = models.ForeignKey(Deduct, on_delete=models.PROTECT)
    has_payed = models.BooleanField(default=False)

    def __str__(self):
        return "Order ship: {},\nShipper: {},\nDeduct: {},\nHas Payed: {}".format(
            self.order_ship, self.shipper.username, self.has_payed
        )


class DebtApp(models.Model):
    order_ship = models.OneToOneField(OrderShip, on_delete=models.PROTECT)
    shipper = models.ForeignKey(User, on_delete=models.PROTECT)
    deduct = models.ForeignKey(Deduct, on_delete=models.PROTECT)
    has_payed = models.BooleanField(default=False)

    def __str__(self):
        return "Order ship: {},\nShipper: {},\nDeduct: {},\nHas Payed: {}".format(
            self.order_ship, self.shipper.username, self.has_payed
        )



