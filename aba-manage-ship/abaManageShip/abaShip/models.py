from enum import Enum
from django.contrib.auth.models import AbstractUser, Group
from django.core.validators import MaxValueValidator, MinValueValidator
from django.db import models
from cloudinary.models import CloudinaryField
from  ckeditor.fields import RichTextField

# Create your models here.

class Notification(models.Model):

    message = models.CharField(max_length=255)
    seen = models.BooleanField(default=True)
    active = models.BooleanField(default=True)
    created_date = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ["-created_date", "seen"]

class User (AbstractUser):

    class Meta:
        ordering = ['id']

    type_gender = (("Male", 'Male'), ("Female", 'Female'), ("Other", 'Other'))

    avatar = CloudinaryField('avatar', null=True)
    phone = models.CharField(max_length=10,null=True)
    first_name = models.CharField(max_length=50, null=True, blank=True)
    last_name = models.CharField(max_length=50, null=True, blank=True)
    gender = models.CharField(max_length=10, choices=type_gender, default=0)
    notifications = models.ManyToManyField(Notification, null=True, blank=True)
    address = models.CharField(max_length=255, null=True, default=None)
    date_of_birth = models.DateField(null=True, default=None)

    def __str__(self):
        return "username: {}".format(self.username)



class Stock(models.Model):
    customer = models.ForeignKey(User,on_delete=models.PROTECT, related_name='stocks',default=None)
    address = models.CharField(max_length=150,null=False)
    name_represent_man = models.CharField(max_length=100, null=False)
    phone = models.CharField(max_length=10, null=False)

    def __str__(self):
        return "Address: {},\n Represent man: {},\nPhone: {}".format(
            self.address,self.name_represent_man, self.phone)

class IDCard(models.Model):
    user = models.OneToOneField(User,on_delete=models.CASCADE,primary_key=True)
    id_card = models.CharField(max_length=12,null=False, unique=True)
    image_card_front = CloudinaryField('image_card_front', null=True)
    image_card_back = CloudinaryField('image_card_back', null=True)
    mfg_date = models.DateTimeField(null=False)
    exp_date = models.DateTimeField(null=False)

    def __str__(self):
        return "Id card: {}".format(self.id_card)



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

    class Meta:
        ordering = ['start_date', 'end_date']
    def __str__(self):
        return "name: {},\ndiscount: {}".format(self.name,self.discount)


class OrderShip(Base):
    NOTYETSHIPPED, SHIPPING, SHIPPED  =range(3)
    STATUS = [
        (NOTYETSHIPPED, 'not yet shipped' ),
        (SHIPPING, 'shipping'),
        (SHIPPED, 'shipped')
    ]

    ZALOPAY, MOMO, CASH = range(3)
    PAY_METHOD = [
        (ZALOPAY, 'Zalo pay'),
        (MOMO, 'Momo'),
        (CASH, 'Cash')
    ]
    Group
    auction_win = models.OneToOneField('auction',related_name='order_ship', on_delete=models.PROTECT,primary_key=True)
    active = models.BooleanField(default=True)
    shipped_date = models.DateTimeField(null=True, blank=True)
    status = models.PositiveSmallIntegerField(choices=STATUS, default=NOTYETSHIPPED)
    pay_method = models.PositiveSmallIntegerField(choices=PAY_METHOD, default=CASH)
    voucher = models.ForeignKey(Voucher, on_delete=models.PROTECT,null=True)
    total = models.DecimalField( max_digits=12, decimal_places=2, default=0)
    payed  = models.BooleanField(default=False)


    def __str__(self):
        return "customer: {},\nshipper: {},\nstatus: {},\ncreated date: {}".format(
            self.auction_win.post.customer.username + " " + self.auction_win.post.customer.last_name,
            self.auction_win.shipper.first_name + " " + self.auction_win.shipper.last_name ,
            self.status,
            self.created_date)


# class OrderShipDetail (models.Model):
#     ZALOPAY, MOMO, CASH = range(3)
#     PAY_METHOD = [
#         (ZALOPAY,'Zalo pay'),
#         (MOMO, 'Momo'),
#         (CASH, 'Cash')
#     ]
#
#     order_ship = models.OneToOneField(OrderShip,on_delete= models.PROTECT, related_name='oder_ship_detail',
#                                       primary_key=True)
#
#     pay_method = models.PositiveSmallIntegerField(choices=PAY_METHOD, default=CASH)
#
#     voucher = models.ForeignKey(Voucher,on_delete=models.PROTECT)
#
#     def __str__(self):
#         return "Pay medthod: {},".format(self.pay_method)


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
    description = models.TextField(null=False)
    # image = models.ImageField(upload_to='item/%Y/%m')
    weight = models.FloatField(null=True)
    is_finish = models.BooleanField(default=False)

    def __str__(self):
        return "Customer: {} {},\nCategory product: {},\nCreated date: {}".format(
            self.customer.first_name, self.customer.last_name,self.category_product_ship, self.created_date)

class ImageItem(models.Model):
    post  = models.ForeignKey(Post,related_name='image_items', on_delete=models.CASCADE)
    image = CloudinaryField('image', null=True)

    def __str__(self):
        return "post: {}".format(self.post.weight)


class Auction(Base):

    class Meta:
        unique_together = ['post','shipper']
        ordering = ['post']

    post = models.ForeignKey(Post,related_name="auctions", on_delete=models.CASCADE)
    shipper = models.ForeignKey(User, related_name='auctions', on_delete=models.CASCADE)
    cost = models.DecimalField(max_digits=14, decimal_places=2, null=False)
    is_win = models.BooleanField(default=False)
    active =  models.BooleanField(default=True)

    def __str__(self):
        return "shipper: {},\nprice: {}".format(self.shipper.first_name, self.cost)


class Rate (Base):

    class Meta:
        unique_together = ('customer','shipper')

    customer = models.ForeignKey(User, related_name='customer_rate', on_delete=models.PROTECT,default=None)
    shipper = models.ForeignKey(User, related_name='rate_shiper', on_delete=models.PROTECT, default=None)
    content = models.TextField(null=True)
    rate = models.PositiveIntegerField(default=1, null=False,
                               validators=[
                                   MaxValueValidator(
                                   limit_value=5, message="Đánh giá nhỏ hơn hoặc bằng 5"),
                                    MinValueValidator(
                                    limit_value=1, message="Đánh giá từ 1 đến 5")
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



