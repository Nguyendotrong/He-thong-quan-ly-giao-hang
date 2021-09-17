import generics as generics
from django.contrib.auth.models import Group
from rest_framework import viewsets, generics, permissions
from ..serializers import UserSerializer, ShipperSerializer

from ..models import User


class ShipperViewSet(viewsets.ViewSet, generics.ListAPIView):
    queryset = User.objects.filter(is_active=True)

    permission_classes = [permissions.IsAuthenticated]

    serializer_class =ShipperSerializer

    def get_queryset(self):

        group = Group.objects.get(name='shipper')
        shippers = group.user_set.filter(is_active=True)
        return shippers