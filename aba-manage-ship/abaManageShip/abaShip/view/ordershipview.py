from rest_framework import viewsets, generics,status
from rest_framework.decorators import action
from rest_framework.exceptions import PermissionDenied, ValidationError
from rest_framework.response import Response

from ..Paginator import BasePagination
from ..models import OrderShip, User, Auction, Post
from ..serializers import (OrderCreateSerializer,
                           OrderSerializer,
                                                     )
from ..permission import (PermissionOrderShip,
                          PermissionViewOrderShip,
                          PermissionUpDateStatusOrder)
from django.core.exceptions import ObjectDoesNotExist

class OrderShipViewSet(viewsets.ViewSet, generics.CreateAPIView, generics.ListAPIView, generics.RetrieveAPIView):
    queryset = OrderShip.objects.filter(active=True)
    pagination_class = BasePagination

    def get_serializer_class(self):
        if self.action == 'create':
            return OrderCreateSerializer
        return OrderSerializer

    # def get_permissions(self):
    #     if self.action in ['list','retrieve']:
    #         return [PermissionViewOrderShip(),]
    #     # if self.action == 'update-status':
    #     #     return [PermissionUpDateStatusOrder(),]
    #     return [PermissionOrderShip(),]


    def get_queryset(self):
        orderShip = self.queryset
        if self.request.user.groups.filter(name='shipper').exists():
            return orderShip.filter(auction_win__shipper_id=self.request.user.pk)
        return orderShip.filter(auction_win__post__customer_id=self.request.user.pk)

    # def list(self, request, *args, **kwargs):
    #     order = self.queryset
    #     if request.user

    def create(self, request, *args, **kwargs):
        """
        Trong phương thức này có ba việc là:
                - thêm order,
                - cập trạng thái is_finish = True cho post tương ứng,
                - cập nhật trạng thái is_win = True cho auction tương ứng
        :param request:
        :param args:
        :param kwargs:
        :return:
        """
        try:
            auction = Auction.objects.get(pk=int(request.data.get('auction_win')))
            print(auction.pk)
        except :
            raise ValidationError(detail="auction_win field is invalid")
        else:
            if request.user.id == auction.post.customer.id and not auction.post.is_finish:
                order_serializer = OrderCreateSerializer(data=request.data)
                order_serializer.is_valid(raise_exception=True)
                order_serializer.save(**{'active':True})
                headers = self.get_success_headers(order_serializer.data)
                post = Post.objects.get(pk=auction.post.pk)
                post.is_finish = True
                post.save()
                auction.is_win = True
                auction.save()
                return Response(order_serializer.data,status=status.HTTP_201_CREATED,headers=headers)
            raise PermissionDenied()

    def retrieve(self, request, *args, **kwargs):
        order = self.get_object()
        if request.user.pk == order.auction_win.post.customer.pk or request.user.pk == order.auction_win.shipper.pk:
           return super().retrieve(request, *args, **kwargs)
        raise PermissionDenied()

    def send_mail_status_order (self,order_id, user, status):
        if status == 1:
            status_string = "shipping"
        elif status == 2:
            status_string = "shipped"
        subject =  "[AbaShip][order {order_id}] [{status_string}]".format(order_id=order_id, status_string=status_string )
        message = 'Order {order_id} had be {status_string}'.format(order_id=order_id, status_string=status_string)
        user.email_user(subject= subject, message=message)

    @action(methods=["PATCH"], detail=True, url_name='update-status',url_path='update-status')
    def update_status(self, request,*args, **kwargs):
        order = self.get_object()
        ser = OrderCreateSerializer(order,data={'status':request.data.get('status')}, partial=True)
        ser.is_valid(raise_exception=True)
        ser.save()
        header = self.get_success_headers(ser.data)
        self.send_mail_status_order(order.auction_win.id, order.auction_win.post.customer, order.status)
        return Response(ser.data,status=status.HTTP_200_OK,headers=header)



    def send_mail_status_order(self, order_id, user, status):
        if status == 1:
            status_string = "shipping"
        elif status == 2:
            status_string = "shipped"
        subject = "[AbaShip][order {order_id}] [{status_string}]".format(order_id=order_id, status_string=status_string)
        message = 'Order {order_id} had be {status_string}'.format(order_id=order_id, status_string=status_string)
        user.email_user(subject=subject, message=message)

    # @action(methods=['POST', 'GET'], detail=True, url_path="order-detail",
    #         url_name="order-detail")
    # def order_detail(self,request,*args, **kwargs):
    #     order = self.get_object()
    #
    #     if request.method == 'POST':
    #         if not OrderShipDetail.objects.filter(pk=order.pk).exists() \
    #             and order.auction_win.post.customer.pk == request.user.pk:
    #
    #
    #             order_Detail_Ser = OrderDetailCreateSerializer(
    #                 data={
    #                     'order_ship' : order.pk,
    #                       'pay_method':request.data.get('pay_method'),
    #                       'voucher': request.data.get('voucher')
    #                       })
    #             order_Detail_Ser.is_valid(raise_exception=True)
    #             order_Detail_Ser.save()
    #             return Response(order_Detail_Ser.data,status=status.HTTP_200_OK)
    #         raise PermissionDenied()
    #
    #     if request.method== "GET":
    #         if request.user.pk in [order.auction_win.shipper.pk, order.auction_win.post.customer.pk]:
    #             order_detail = OrderShipDetail.objects.filter(pk=order.pk)
    #
    #
    #             return Response(OrderDetailSerializer(order_detail).data,)
    #
    #         raise PermissionDenied()
    #
