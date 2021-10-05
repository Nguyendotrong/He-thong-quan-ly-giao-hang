from datetime import datetime

from rest_framework import viewsets, generics, permissions

from ..Paginator import BasePagination
from ..models import Voucher
from ..serializers import VoucherSerializer
class VoucherViewSet(viewsets.ViewSet, generics.ListAPIView,generics.RetrieveAPIView):

    queryset =Voucher.objects.filter(end_date__day__gte=datetime.now().day)
    pagination_class = BasePagination
    serializer_class = VoucherSerializer