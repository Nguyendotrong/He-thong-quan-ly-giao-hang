# Generated by Django 3.2.6 on 2021-08-16 14:19

import abaShip.models
import ckeditor.fields
from django.conf import settings
import django.contrib.auth.models
import django.contrib.auth.validators
import django.core.validators
from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('auth', '0012_alter_user_first_name_max_length'),
    ]

    operations = [
        migrations.CreateModel(
            name='User',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('password', models.CharField(max_length=128, verbose_name='password')),
                ('last_login', models.DateTimeField(blank=True, null=True, verbose_name='last login')),
                ('is_superuser', models.BooleanField(default=False, help_text='Designates that this user has all permissions without explicitly assigning them.', verbose_name='superuser status')),
                ('username', models.CharField(error_messages={'unique': 'A user with that username already exists.'}, help_text='Required. 150 characters or fewer. Letters, digits and @/./+/-/_ only.', max_length=150, unique=True, validators=[django.contrib.auth.validators.UnicodeUsernameValidator()], verbose_name='username')),
                ('email', models.EmailField(blank=True, max_length=254, verbose_name='email address')),
                ('is_staff', models.BooleanField(default=False, help_text='Designates whether the user can log into this admin site.', verbose_name='staff status')),
                ('is_active', models.BooleanField(default=True, help_text='Designates whether this user should be treated as active. Unselect this instead of deleting accounts.', verbose_name='active')),
                ('date_joined', models.DateTimeField(default=django.utils.timezone.now, verbose_name='date joined')),
                ('avatar', models.ImageField(upload_to='avatar/%Y/%m/')),
                ('phone', models.CharField(max_length=10)),
                ('first_name', models.CharField(max_length=50)),
                ('last_name', models.CharField(max_length=50)),
                ('groups', models.ManyToManyField(blank=True, help_text='The groups this user belongs to. A user will get all permissions granted to each of their groups.', related_name='user_set', related_query_name='user', to='auth.Group', verbose_name='groups')),
                ('user_permissions', models.ManyToManyField(blank=True, help_text='Specific permissions for this user.', related_name='user_set', related_query_name='user', to='auth.Permission', verbose_name='user permissions')),
            ],
            options={
                'verbose_name': 'user',
                'verbose_name_plural': 'users',
                'abstract': False,
            },
            managers=[
                ('objects', django.contrib.auth.models.UserManager()),
            ],
        ),
        migrations.CreateModel(
            name='Auction',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created_date', models.DateTimeField(auto_now_add=True)),
                ('update_date', models.DateTimeField(auto_now=True)),
                ('cost', models.DecimalField(decimal_places=2, max_digits=14)),
                ('is_win', models.BooleanField(default=False)),
                ('active', models.BooleanField(default=True)),
            ],
            options={
                'ordering': ['post'],
            },
        ),
        migrations.CreateModel(
            name='Deduct',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created_date', models.DateTimeField(auto_now_add=True)),
                ('update_date', models.DateTimeField(auto_now=True)),
                ('percent', models.FloatField(validators=[django.core.validators.MaxValueValidator(40.0), django.core.validators.MinValueValidator(0.0)])),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='Post',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created_date', models.DateTimeField(auto_now_add=True)),
                ('update_date', models.DateTimeField(auto_now=True)),
                ('active', models.BooleanField(default=True)),
                ('description', ckeditor.fields.RichTextField()),
                ('receive_adress', models.TextField()),
                ('send_adress', models.TextField(null=True)),
                ('weight', models.FloatField(null=True)),
                ('customer', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='Stock',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('address', models.CharField(max_length=150)),
                ('name_represent_man', models.CharField(max_length=100)),
                ('phone', models.CharField(max_length=10)),
            ],
        ),
        migrations.CreateModel(
            name='Voucher',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created_date', models.DateTimeField(auto_now_add=True)),
                ('update_date', models.DateTimeField(auto_now=True)),
                ('name', models.CharField(max_length=200)),
                ('description', models.TextField()),
                ('discount', models.FloatField()),
                ('start_date', models.DateTimeField()),
                ('end_date', models.DateTimeField()),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='IDCard',
            fields=[
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, primary_key=True, serialize=False, to='abaShip.user')),
                ('id_card', models.CharField(max_length=12, unique=True)),
                ('image_card_front', models.ImageField(default=None, upload_to='idcard/%Y/%m/')),
                ('image_card_back', models.ImageField(default=None, upload_to='idcard/%Y/%m/')),
                ('mfg_date', models.DateTimeField()),
                ('exp_date', models.DateTimeField()),
            ],
        ),
        migrations.CreateModel(
            name='OrderShip',
            fields=[
                ('created_date', models.DateTimeField(auto_now_add=True)),
                ('update_date', models.DateTimeField(auto_now=True)),
                ('auction_win', models.OneToOneField(on_delete=django.db.models.deletion.PROTECT, primary_key=True, serialize=False, to='abaShip.auction')),
                ('active', models.BooleanField(default=True)),
                ('shipped_date', models.DateTimeField(default=None, null=True)),
                ('status', models.CharField(choices=[(abaShip.models.StatusShip['SHIPPED'], 'shipped'), (abaShip.models.StatusShip['SHIPPING'], 'shipping'), (abaShip.models.StatusShip['NOTYETSHIPPED'], 'not yet shipped')], max_length=30)),
                ('receive_stock', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='orders_ship_receive', to='abaShip.stock')),
                ('send_stock', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='orders_ship_send', to='abaShip.stock')),
                ('shipper', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, related_name='shipper_orders', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='ImageItem',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image', models.ImageField(upload_to='item/%Y/%m/')),
                ('post', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='abaShip.post')),
            ],
        ),
        migrations.AddField(
            model_name='auction',
            name='post',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='autions', to='abaShip.post'),
        ),
        migrations.AddField(
            model_name='auction',
            name='shipper',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='autions', to=settings.AUTH_USER_MODEL),
        ),
        migrations.CreateModel(
            name='CommentShipper',
            fields=[
                ('created_date', models.DateTimeField(auto_now_add=True)),
                ('update_date', models.DateTimeField(auto_now=True)),
                ('order_ship', models.OneToOneField(on_delete=django.db.models.deletion.PROTECT, primary_key=True, serialize=False, to='abaShip.ordership')),
                ('content', models.TextField()),
                ('rate', models.IntegerField(default=1, validators=[django.core.validators.MaxValueValidator(limit_value=5, message='Đánh giá nhỏ hơn hoặc bằng 5'), django.core.validators.MinValueValidator(limit_value=1, message='đánh giá từ 1 đến 5')])),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='OrderShipDetail',
            fields=[
                ('orderShip', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, primary_key=True, serialize=False, to='abaShip.post')),
                ('pay_method', models.CharField(choices=[(abaShip.models.PayMethod['ZALO'], 'ZALO'), (abaShip.models.PayMethod['MOMO'], 'MOMO'), (abaShip.models.PayMethod['TIENMAT'], 'TIENMAT')], max_length=20)),
                ('voucher', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='abaShip.voucher')),
            ],
        ),
        migrations.CreateModel(
            name='DebtShipper',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('has_payed', models.BooleanField(default=False)),
                ('deduct', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='abaShip.deduct')),
                ('shipper', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to=settings.AUTH_USER_MODEL)),
                ('order_ship', models.OneToOneField(on_delete=django.db.models.deletion.PROTECT, to='abaShip.ordership')),
            ],
        ),
        migrations.CreateModel(
            name='DebtApp',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('has_payed', models.BooleanField(default=False)),
                ('deduct', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='abaShip.deduct')),
                ('shipper', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to=settings.AUTH_USER_MODEL)),
                ('order_ship', models.OneToOneField(on_delete=django.db.models.deletion.PROTECT, to='abaShip.ordership')),
            ],
        ),
        migrations.AlterUniqueTogether(
            name='auction',
            unique_together={('post', 'shipper')},
        ),
    ]
