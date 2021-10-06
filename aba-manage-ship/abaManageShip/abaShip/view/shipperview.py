import generics as generics
from django.contrib.auth.models import Group
from rest_framework import viewsets, generics, permissions,status
from rest_framework.response import Response
from rest_framework.decorators import action

from ..serializers import UserSerializer, ShipperSerializer
from ..models import User
from ..Paginator import BasePagination


class ShipperViewSet(viewsets.ViewSet, generics.ListAPIView, generics.RetrieveAPIView):
    queryset = User.objects.filter(is_active=True)

    permission_classes = [permissions.IsAuthenticated]

    serializer_class =ShipperSerializer
    pagination_class = BasePagination

    def get_queryset(self):

        group = Group.objects.get(name='shipper')
        shippers = group.user_set.filter(is_active=True)
        return shippers

    def retrieve(self, request, *args, **kwargs):
        shipper = self.get_object()
        if shipper.groups.filter(name='shipper').exists():
            return super().retrieve(self,request,*args,**kwargs)
        return Response(status=status.HTTP_404_NOT_FOUND)

    @action(methods=['GET'],detail=True,url_path="average-rate", url_name='average-rate')
    def average_rate(self,request, *args, **kwargs):
        shiper = self.get_object()
        list_rate = shiper.rate_shiper.all()
        ave = 0
        if len(list_rate) > 0:

            for i in list_rate:
                ave = ave + i.rate

            ave = round(ave/len(list_rate),1)

        return Response({'ave': ave},status=status.HTTP_200_OK)