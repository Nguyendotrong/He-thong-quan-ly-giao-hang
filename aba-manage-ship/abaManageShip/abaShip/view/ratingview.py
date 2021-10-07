from django.db import IntegrityError
from rest_framework import status, permissions, viewsets ,generics
from rest_framework.decorators import action
from rest_framework.exceptions import PermissionDenied, ValidationError
from rest_framework.response import Response

from ..models import Rate, OrderShip, User
from ..serializers import RatingCreateSerializer, RatingSerializer
from ..permission import PermissionViewRatingShipper, PermissionRatingShipper




class RatingViewSet(viewsets.ViewSet, generics.CreateAPIView,
                    generics.ListAPIView,generics.RetrieveAPIView,generics.UpdateAPIView):

    queryset = Rate.objects.all()

    def get_serializer_class(self):
        if  self.action in ['list','retrieve']:
            return RatingSerializer
        return RatingCreateSerializer

    def get_permissions(self):
        if  self.action in ['list','retrieve']:
            return [PermissionViewRatingShipper(),]
        return [PermissionRatingShipper(),]

    def get_queryset(self):
        rate = self.queryset.order_by('-created_date')
        shipper = self.request.query_params.get('shipper')
        if shipper is not None:
            try:
                rate = rate.filter(shipper=shipper)
            except ValueError:
                raise ValidationError(detail="shipper id invalid")
        return rate
    def create(self, request, *args, **kwargs):
        """
        Body: rate, content, order_id
        :param request:
        :param args:
        :param kwargs:
        :return:
        """
        customer = request.user
        try:
            order_id = request.data.get('order_id')
            order = OrderShip.objects.filter(pk=order_id)
        except :
            raise ValidationError(detail='order_id input invalid')

        if order.exists():
            if order.first().auction_win.post.customer.pk == customer.pk:

                ser = RatingCreateSerializer(data=request.data)
                ser.is_valid(raise_exception=True)
                try:
                    ser.save(**{'customer': customer,
                            'shipper': order.first().auction_win.shipper})
                except IntegrityError :
                    raise ValidationError(detail="you already rate this shipper!")
                headers = self.get_success_headers(ser.data)
                return Response(ser.data, status=status.HTTP_201_CREATED, headers=headers)


        return Response(status=status.HTTP_404_NOT_FOUND)


    def update(self, request, *args, **kwargs):
        rate = self.get_object()
        if request.user.pk == rate.customer.pk:
            partial = kwargs.pop('partial', False)
            instance = self.get_object()
            serializer = self.get_serializer(instance, data=request.data, partial=partial)
            serializer.is_valid(raise_exception=True)
            self.perform_update(serializer)

            if getattr(instance, '_prefetched_objects_cache', None):
                # If 'prefetch_related' has been applied to a queryset, we need to
                # forcibly invalidate the prefetch cache on the instance.
                instance._prefetched_objects_cache = {}

            return Response(serializer.data)
        raise PermissionDenied()

    def perform_update(self, serializer):
        serializer.save()

    def partial_update(self, request, *args, **kwargs):
        rate = self.get_object()
        if request.user.pk == rate.customer.pk:
            kwargs['partial'] = True
            return self.update(request, *args, **kwargs)
        raise PermissionDenied()

    @action(methods=['POST'], detail=False, url_path='check-rate', url_name='check-rate')
    def check_rate(self,request, *args, **kwargs):
        customer  =  request.user.pk
        try:
            shipper = int(request.data.get('shipper'))

            rate = Rate.objects.filter(customer=customer, shipper=shipper)
        except:
            ValidationError(detail="shipper input invalid")
        else:
            if not User.objects.filter(pk=shipper).exists():
                raise ValidationError(detail="shipper input invalid")
            if rate.exists():
                return Response({'check':True})
            return Response({'check':False})
