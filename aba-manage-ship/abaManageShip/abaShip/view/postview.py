from rest_framework import status, permissions, viewsets
from rest_framework.decorators import action
from rest_framework.exceptions import PermissionDenied
from rest_framework.response import Response

from ..models import Post
from ..permission import PermissionViewPost, PermissionPost
from ..serializers import ImageItemSerializer, PostSerializer, PostCreateSerializer


class PostViewSet(viewsets.ModelViewSet):
    queryset = Post.objects.filter(active=True)
    # serializer_class = PostSerializer

    def get_serializer_class(self):
        if self.action == 'create':
            return PostCreateSerializer
        return PostSerializer

    def get_permissions(self):

        if self.action == 'list':
            return [PermissionViewPost(),]

        return [PermissionPost(),]


    def list(self, request, *args, **kwargs):

        #Ghi đè lại lấy theo list post theo user hiện tại
        queryset = Post.objects.filter(customer = self.request.user)

        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)

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

        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        imgs = request.FILES.getlist('image_items', None)
        print(imgs)
        instance_post = serializer.save(**{'customer': self.request.user})
        for img in imgs:
            print(img)
            serializer_img = ImageItemSerializer(data={"image":img,'post':instance_post.id})
            serializer_img.is_valid(raise_exception=True)
            instance_img = serializer_img.save()
            # instance_post.image_items.add(instance_img)

        headers = self.get_success_headers(serializer.data)
        return Response(PostSerializer(instance=instance_post).data,
                        status=status.HTTP_201_CREATED, headers=headers)

    # def perform_create(self, serializer):
    #     return serializer.save(**{'customer': self.request.user})
