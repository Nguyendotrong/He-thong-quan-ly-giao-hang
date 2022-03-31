from rest_framework import status, permissions, viewsets
from rest_framework.exceptions import PermissionDenied
from rest_framework.response import Response

from ..models import Stock
from ..permission import PermissionViewStock, PermissionStock
from ..serializers import StockSerializer, StockCreateSerializer


class StockViewSet(viewsets.ModelViewSet):
    queryset = Stock.objects.all()
    # permission_classes = [permissions.IsAuthenticated]

    def get_serializer_class(self):
        if self.action == 'create':
            return  StockCreateSerializer
        return StockSerializer

    def get_permissions(self):
        if self.action == 'list':
            return [PermissionViewStock(),]

        return [PermissionStock(),]

    def get_queryset(self):
        stock = self.queryset

        if self.action in ["list", "retrieve"]:
            if self.request.user.groups.filter(name='customer').exists():
                return stock.filter(customer=self.request.user)


        return stock

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        instance = serializer.save(**{'customer': self.request.user})
        headers = self.get_success_headers(serializer.data)
        return  Response(StockSerializer(instance=instance).data,
                         status=status.HTTP_201_CREATED, headers=headers)

    # def list(self, request, *args, **kwargs):
    #     queryset = Stock.objects.filter(customer= self.request.user)
    #     page = self.paginate_queryset(queryset)
    #
    #     if page is not None:
    #         serializer = self.get_serializer(page, many=True)
    #         return self.get_paginated_response(serializer.data)
    #
    #     serializer = self.get_serializer(queryset, many=True)
    #     return Response(serializer.data)


    def destroy(self, request, *args, **kwargs):
            # xóa stock của chính user đó nếu khác thì không đc
        instance = self.get_object()
        if instance.user_id == request.user.id:
            self.perform_destroy(instance)
            return Response(status=status.HTTP_204_NO_CONTENT)
        raise PermissionDenied()

    def update(self, request, *args, **kwargs):
        # print(type(kwargs.get('pk')))
        instance = self.get_object()
        if request.user.id == instance.customer.id:
            return super().update(request, *args, **kwargs)
        raise PermissionDenied()