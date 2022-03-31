from rest_framework import status, permissions, viewsets ,generics
from rest_framework.decorators import action
from rest_framework.exceptions import PermissionDenied
from rest_framework.response import Response
from django.http import Http404


from ..models import Post, CategoryProductShip, Auction, Stock
from .auctionview import AuctionViewSet
from ..permission import (PermissionViewPost,
                          PermissionPost,
                          PermissionAddAuctionIntoPost,
                          PermissionViewListAuctionOnPost,
                          )
from ..serializers import (ImageItemSerializer,
                           PostSerializer,
                           PostCreateSerializer,
                           AuctionSerializer,
    AuctionCreateSerializer)
from  ..Paginator import BasePagination

class PostViewSet(viewsets.ViewSet, generics.CreateAPIView,
                  generics.RetrieveAPIView, generics.ListAPIView,
                  generics.UpdateAPIView, generics.DestroyAPIView):
    queryset = Post.objects.filter(active=True)
    # serializer_class = PostSerializer
    pagination_class = BasePagination


    def get_serializer_class(self):
        if self.action in ['create','update']:
            return PostCreateSerializer
        return PostSerializer

    def get_permissions(self):

        if self.action in ['list','retrieve'] :
            return [PermissionViewPost(),]
        if self.action == 'auctions':
            if self.request.method == 'POST':
                return [PermissionAddAuctionIntoPost(),]
            if self.request.method == 'GET':
                return  [PermissionViewListAuctionOnPost(),]
        # if self.action == ''

        return [PermissionPost(),]


    def get_queryset(self):
        post = self.queryset.order_by('created_date')
        cate = self.request.query_params.get('category')
        if cate is not None:
            instance_category = CategoryProductShip.objects.get(name__icontains=cate)
            post = instance_category.posts.filter(active=True)

        # print(self.request.user.groups)

        if self.request.user.groups.filter(name='customer').exists():
            return post.filter(customer=self.request.user)
        return post.exclude(is_finish = True)

    def retrieve(self, request, *args, **kwargs):
        post = self.get_object()
        if request.user.pk == post.customer.pk or request.user.groups.filter(name='shipper').exists():
           return super().retrieve(request, *args, **kwargs)
        raise PermissionDenied()

    def destroy(self, request, *args, **kwargs):
        # xóa bài viết của chính user đó nếu khác thì không đc
        post = self.get_object()
        if not post.auctions.filter(is_win=True).exists() and post.customer == request.user:
            # auctions = post.auctions.all()
            # if auctions is not None:
            #     for auc in auctions:
            #         AuctionViewSet.destroy(auc)
            # image_items = post.image_items.all()
            return super().destroy(request, *args, **kwargs)
        raise PermissionDenied()


    @action(methods=['post'], detail=True, url_path='hide-post',
            url_name='hide-post')
    def hide_post(self, reuqest, pk):
        try:
            post = Post.objects.get(pk=pk)
            post.active = False
            post.save()
        except post.DoesNotExits:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        return Response(data=PostSerializer(post, context={'request': reuqest}).data, status=status.HTTP_200_OK)

    def create(self, request, *args, **kwargs):
        # print("kho:" + request.data['send_stock'])
        # recieve_stock = request.data.get('receive_stock')
        # send_stock = request.data.get('send_stock',None)
        #
        # print( "kho gửi:" + str(send_stock) + " kho nhận: " + str(recieve_stock))
        # if send_stock == recieve_stock:
        #     return Response(status=status.HTTP_400_BAD_REQUEST)
        if request.user.groups.filter(name='customer').exists():
            serializer = self.get_serializer(data=request.data)
            serializer .is_valid(raise_exception=True)
            imgs = request.FILES.getlist('image_items', None)
            # print(imgs)
            instance_post = serializer.save(**{'customer': self.request.user})

            for img in imgs:
                # print(img)
                serializer_img = ImageItemSerializer(data={"image":img,'post':instance_post.id})
                serializer_img.is_valid(raise_exception=True)
                instance_img = serializer_img.save()
                instance_post.image_items.add(instance_img)

            headers = self.get_success_headers(serializer.data)
            return Response(PostSerializer(instance=instance_post).data,
                        status=status.HTTP_201_CREATED, headers=headers)
        raise PermissionDenied()


    def check_stock(id):
        if Stock.objects.filter(pk=id).exists():
            return True
        return False
    def update(self, request, *args, **kwargs):
        post = self.get_object()

        if not post.auctions.filter().exists() and request.user.id == post.customer.id:

            image_items_new = request.FILES.getlist('image_items', None)
            # print(image_items_new)

            if len(image_items_new) > 0:
                image_items_old = post.image_items.all()
                for item in image_items_old:
                    item.delete()
                for item in image_items_new:
                    serializer_img = ImageItemSerializer(data={"image": item, 'post': post.id})
                    serializer_img.is_valid(raise_exception=True)
                    instance_img = serializer_img.save()
                    # post.image_items.add(instance_img)

            # send_stock = int(request.data.get('send_stock'))
            # receive_stock = int(request.data.get('receive_stock'))
            #
            # if send_stock is not None:
            #     print("send tock" + str(send_stock))
            #     if Stock.objects.filter(pk=send_stock).exists():
            #         post.send_stock = Stock.objects.get(pk=send_stock)
            #     else:
            #         return Response(status=status.HTTP_400_BAD_REQUEST)
            #
            # if receive_stock is not None:
            #     if Stock.objects.filter(pk=receive_stock).exists():
            #         post.receive_stock = Stock.objects.get(pk=receive_stock)
            #     else:
            #         return Response(status=status.HTTP_400_BAD_REQUEST)
            #
            # post.save()

            serializer = PostCreateSerializer(post,data=request.data,partial=True)
            serializer.is_valid(raise_exception=True)
            instance = serializer.save()
            headers = self.get_success_headers(serializer.data)
            return Response(PostSerializer(instance=instance).data, status=status.HTTP_200_OK, headers=headers)

        raise PermissionDenied()

    @action(methods=['POST', 'GET'], detail=True, url_path='auctions',url_name='auctions' )
    def auctions(self,request,pk):
        """
        shipper thêm 1 auction vào post
        :param request:
        :param pk:
        :return:
        """
        if request.method == 'POST':
            post = self.get_object()
            if not post.auctions.filter(is_win=True).exists()  and request.user.groups.filter(name='shipper').exists():

                auc_serializer = AuctionCreateSerializer(
                    data={'shipper': request.user.pk, 'post': post.pk, 'cost': request.data.get('cost')})
                auc_serializer.is_valid(raise_exception=True)

                auc_instance = auc_serializer.save()

                post.customer.email_user(subject= "[AbaShip][New Auction]",
                                         message='bài đấu giá "{description}..." có một đấu giá mới'.format(description=post.description[0:50] ))
                return Response(AuctionSerializer(auc_instance).data, status=status.HTTP_200_OK)
            raise PermissionDenied()

        if request.method == 'GET':
            if(request.user.pk == self.get_object().customer.pk):
                post = self.get_object()
                auctions = post.auctions.filter(active=True)
                return Response(AuctionSerializer(auctions, many=True).data, status=status.HTTP_200_OK)
            return Response(status=status.HTTP_403_FORBIDDEN)



