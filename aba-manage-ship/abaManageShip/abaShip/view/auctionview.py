from django.db.models import Q
from requests import Response
from rest_framework import viewsets,generics
from rest_framework.exceptions import PermissionDenied


from ..models import Auction
from ..permission import PermissionViewDetailAuction, PermissionViewListAuctionOfShipper, PermissionAuction
from ..serializers import AuctionSerializer


class AuctionViewSet(viewsets.ViewSet,generics.ListAPIView,
                     generics.RetrieveAPIView, generics.UpdateAPIView,generics.DestroyAPIView):
    queryset = Auction.objects.filter(active=True)

    def get_serializer_class(self):
        return AuctionSerializer

    # def get_permissions(self):
    #     if self.action == "retrieve":
    #         return [PermissionViewDetailAuction(),]
    #     # if self.action == "list":
    #     #     return [PermissionViewListAuctionOfShipper(),]
    #     return [PermissionAuction(),]

    def get_queryset(self):

        if self.request.user.groups.filter(name='customer').exists():
            return self.queryset.filter(post__customer_id=self.request.user.pk)
        return self.queryset.filter(shipper=self.request.user)

        return self.queryset

    # def list(self, request, *args, **kwargs):
    #
    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        if   request.user.pk in [instance.post.customer.pk, instance.shipper.pk]:
            return super().retrieve(request, *args, **kwargs)
        raise PermissionDenied()

    def update(self, request, *args, **kwargs):
        auction = self.get_object()
        if not auction.post.auctions.filter(is_win=True).exists() and request.user.id == auction.shipper.id:
            return super().update(request, *args, **kwargs)
        raise PermissionDenied()

    def destroy(self, request, *args, **kwargs):
        auction = self.get_object()
        if not auction.post.auctions.filter(is_win=True).exists() and request.user.id == auction.shipper.id:
            return super().destroy(request, *args, **kwargs)
        raise PermissionDenied()
