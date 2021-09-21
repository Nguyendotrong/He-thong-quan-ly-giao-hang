from rest_framework import viewsets, generics,status
from rest_framework.exceptions import PermissionDenied
from rest_framework.response import Response

from ..permission import PermissionOrderShipDetail, PermissionViewOrderShip

class OrderDetailViewSet(viewsets.ViewSet,generics.UpdateAPIView):
    pass