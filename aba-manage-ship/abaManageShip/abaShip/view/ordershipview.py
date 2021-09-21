from rest_framework import viewsets, generics,status
from rest_framework.exceptions import PermissionDenied
from rest_framework.response import Response
from ..models import OrderShip, User, Auction, Post
from ..serializers import OrderCreateSerializer,OrderSerializer
from ..permission import PermissionOrderShip,PermissionViewOrderShip
from django.core.exceptions import ObjectDoesNotExist

class OrderShipViewSet(viewsets.ViewSet, generics.CreateAPIView, generics.ListAPIView, generics.RetrieveAPIView):
    queryset = OrderShip.objects.filter(active=True)

    def get_serializer_class(self):
        if self.action == 'create':
            return OrderCreateSerializer
        return OrderSerializer

    def get_permissions(self):
        if self.action in ['list','retrieve']:
            return [PermissionViewOrderShip(),]
        return [PermissionOrderShip(),]


    def get_queryset(self):
        orderShip = self.queryset
        if self.request.user.groups.filter(name='shipper').exists():
            return orderShip.filter(auction_win__shipper_id=self.request.user.pk)
        return orderShip.filter(auction_win__post__customer_id=self.request.user.pk)

    def create(self, request, *args, **kwargs):
        try:
            auction = Auction.objects.get(pk=int(request.data.get('auction_win')))
            print(auction.pk)
        except :
            return Response(status=status.HTTP_400_BAD_REQUEST)
        else:
            if request.user.id == auction.post.customer.id and not auction.post.is_finish:
                order_serializer = OrderCreateSerializer(data={'auction_win':auction.pk})
                order_serializer.is_valid(raise_exception=True)
                order_serializer.save()
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
        if request.user.pk == order.auction_win.post.customer.pk or request.user.id == order.auction_win.shipper.id:
           return super().retrieve(request, *args, **kwargs)
        raise PermissionDenied()

