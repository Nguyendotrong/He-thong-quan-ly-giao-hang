# from rest_framework import viewsets, generics,status
# from rest_framework.exceptions import PermissionDenied
# from rest_framework.response import Response
#
# from ..permission import PermissionOrderShipDetail, PermissionViewOrderShipDetail
# from  ..serializers import OrderDetailSerializer, OrderDetailCreateSerializer
# from .. models import OrderShipDetail, OrderShip
#
# class OrderDetailViewSet(viewsets.ViewSet, generics.UpdateAPIView, generics.CreateAPIView, generics.RetrieveAPIView):
#
#     queryset = OrderShipDetail.objects.all()
#
#     def get_serializer_class(self):
#         if self.action == "list":
#             return OrderDetailSerializer
#         return OrderDetailCreateSerializer
#
#     def get_permissions(self):
#         if self.action in ['list', 'retrieve']:
#             return [PermissionViewOrderShipDetail(),]
#         return [PermissionOrderShipDetail(),]
#
#     def update(self, request, *args, **kwargs):
#         order_detail = self.get_object()
#
#         if order_detail.order.auction_win.post.customer.pk == request.user.pk:
#             return super().update(self,request,partial=True)
#
#     # def retrieve(self, request, *args, **kwargs):
#     #     pass
#     #
#     # def create(self, request, *args, **kwargs):
#     #     order_id = request.data.get('rderShip')
#     #     order = OrderShip.objects.filter(pk=order_id)
#     #     if not OrderShipDetail.objects.filter(pk=order_id).exists()\
#     #             and order.auction_win.post.customer.pk == request.user.pk: