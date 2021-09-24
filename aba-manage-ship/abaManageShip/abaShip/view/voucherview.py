from datetime import datetime

from rest_framework import viewsets, generics, permissions
from ..models import Voucher
from ..serializers import VoucherSerializer
class VoucherViewSet(viewsets.ViewSet, generics.ListAPIView,generics.RetrieveAPIView):

    queryset =Voucher.objects.filter(end_date__day__gte=datetime.now().day)
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = VoucherSerializer