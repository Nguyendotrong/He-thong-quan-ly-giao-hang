import generics as generics
from rest_framework import viewsets, generics, permissions
from ..serializers import UserSerializer

from abaManageShip.abaShip.models import User


# class ShipperViewSet(viewsets.ViewSet, generics.ListAPIView):
#     queryset = User.objects.filter(active=True)
#
#     permission_classes = [permissions.IsAuthenticated]
#
#     serializer_class =