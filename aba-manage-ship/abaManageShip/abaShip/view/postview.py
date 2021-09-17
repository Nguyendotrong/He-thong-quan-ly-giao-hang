from rest_framework import status, permissions, viewsets
from rest_framework.decorators import action
from rest_framework.exceptions import PermissionDenied
from rest_framework.response import Response
from django.http import Http404

from ..models import Post, CategoryProductShip, Auction
from ..permission import PermissionViewPost, PermissionPost, PermissionAddAuctionIntoPost
from ..serializers import ImageItemSerializer, PostSerializer, PostCreateSerializer
from  ..Paginator import BasePagination

class PostViewSet(viewsets.ModelViewSet):
    queryset = Post.objects.filter(active=True)
    # serializer_class = PostSerializer
    pagination_class = BasePagination

    def get_serializer_class(self):
        if self.action == 'create':
            return PostCreateSerializer
        return PostSerializer

    def get_permissions(self):

        if self.action in ['list','retrieve'] :
            return [PermissionViewPost(),]
        if self.action == 'add_auction':
            return [PermissionAddAuctionIntoPost(),]

        return [PermissionPost(),]


    def get_queryset(self):
        post = self.queryset
        category = self.request.query_params.get('category')
        if category is not None:
            post = CategoryProductShip.posts.filter(active=True)

        # print(self.request.user.groups)
        if self.action in ["list","retrieve"]:
            if self.request.user.groups.filter(name='customer').exists():
                return post.filter(customer = self.request.user)
        return post



    def destroy(self, request, *args, **kwargs):
        # xóa bài viết của chính user đó nếu khác thì không đc
        instance = self.get_object()
        if instance.customer == request.user:
            self.perform_destroy(instance)
            return Response(status=status.HTTP_204_NO_CONTENT)
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
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        imgs = request.FILES.getlist('image_items', None)
        # print(imgs)
        instance_post = serializer.save(**{'customer': self.request.user})

        for img in imgs:
            print(img)
            serializer_img = ImageItemSerializer(data={"image":img,'post':instance_post.id})
            serializer_img.is_valid(raise_exception=True)
            instance_img = serializer_img.save()
            instance_post.image_items.add(instance_img)

        headers = self.get_success_headers(serializer.data)
        return Response(PostSerializer(instance=instance_post).data,
                        status=status.HTTP_201_CREATED, headers=headers)

    def update(self, request, *args, **kwargs):
        print(kwargs.get('pk'))
        if str(request.user.id) == kwargs.get("pk"):
            return super().update(request, *args, **kwargs)
        raise PermissionDenied()

    @action(methods=['post'], detail=True, url_path='auctions' )
    def add_auction(self,request, pk):
        try:
            post = self.get_object()
            print(post)
        except Http404:
            return Response(status=status.HTTP_404_NOT_FOUND)
        else:
            # auc_serializer =
            auction = Auction(**request.data)
            auction.post = post
            auction.shipper = self.request.user
            instance_auc = Auction.objects.create(auction)
            post.auctions.add(instance_auc)

            return Response(self.serializer_class(post), status=status.HTTP_201_CREATED)

    # def perform_create(self, serializer):
    #     return serializer.save(**{'customer': self.request.user})
