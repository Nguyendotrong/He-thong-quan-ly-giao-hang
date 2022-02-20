from oauth2_provider.contrib.rest_framework import permissions
from rest_framework import viewsets, generics, status
from rest_framework.parsers import JSONParser
from rest_framework.response import Response

from ..util.util import create_hash_by_RSA, create_signature
from ..models import Auction, User
from ..serializers import MomoPaySerializer


class MomoPay(viewsets.ViewSet, generics.CreateAPIView):
    parser_classes = [JSONParser]
    serializer_class = MomoPaySerializer

    def get_permissions(self):
        return [permissions.IsAuthenticated()]

    def create(self, request, *args, **kwargs):
        auction_id = request.data.get('auction_id')
        user_id = request.data.get('user_id')
        # phonenumber = request.data.get('phonenumber')
        data = request.data.get('momo_token')

        try:
            auction = Auction.objects.get(pk=auction_id)
        except Auction.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        try:
            user = User.objects.get(pk=user_id)
        except User.DoesNotExist:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        partnerCode = "MOMOIDXP20220219"
        billId = "Kanj-auctionId_%s-commentId_%s" % (auction.id, user.id)  # ma don hang
        storeId = 'QWdaiai149274y44'
        storeSlug = 'MOMOIDXP20220219-220219221215671baa52'
        amount = auction.cost
        domain = 'https://test-payment.momo.vn'

        signature = create_signature(storeSlug=storeSlug, amount=auction.cost, orderId=billId)
        url = "https://test-payment.momo.vn/pay/store/{0}?a={1}&b={2}&s={3}".format(storeSlug, auction.cost, billId, signature)

        return Response(data={"url": url}, status=status.HTTP_200_OK )