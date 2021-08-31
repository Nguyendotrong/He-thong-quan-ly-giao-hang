from django.contrib.auth import authenticate, login, logout
from django.shortcuts import render, redirect
from django.views import View
from oauth2_provider.models import Application
from rest_framework import viewsets, permissions, status, generics
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser
from .serializers import *


class Index(View):
    def get(self, request):
        o = Application.objects.get(pk=1)

        return render(request, template_name="index.html", context={"oauth2": o})


class UserViewSet(viewsets.ViewSet, generics.CreateAPIView, generics.RetrieveAPIView,generics.ListAPIView):
    queryset = User.objects.filter(is_active=True)
    # serializer_class = UserSerializer
    parser_classes = [MultiPartParser, ]


    def get_serializer_class(self):
        if self.action == 'create':
            return UserRegisterSerializer
        return UserSerializer

    @action(methods=['get'], detail=False, url_path='current-user')
    def current_user(self, request):
        return Response(self.get_serializer(request.user).data)

    def get_permissions(self):
        if self.action == 'current_user':
            return [permissions.IsAuthenticated()]
        return [permissions.AllowAny()]


    def list(self, request, *args, **kwargs):
        return Response(status=status.HTTP_404_NOT_FOUND)

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        instance = serializer.save()
        headers = self.get_success_headers(instance)
        return Response(UserSerializer(instance).data, status=status.HTTP_201_CREATED, headers=headers)

    @action(methods=["GET"], detail=False, url_path="logout", name="logout")
    def logout(self, request, *args, **kwargs):
        logout(request)
        if request.auth:
            request.auth.revoke()
        return Response(status=status.HTTP_200_OK)

class PostViewSet(viewsets.ModelViewSet):
    queryset = Post.objects.filter(active=True)
    # serializer_class = PostSerializer


    def get_serializer_class(self):
        if self.action == 'create':
            return PostCreateSerializer
        return PostSerializer

    def get_permissions(self):

        if self.action == 'list':
            return [permissions.AllowAny()]

        return [permissions.AllowAny()]

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


class StockViewSet(viewsets.ModelViewSet):
    queryset = Stock.objects.all()
    permission_classes = [permissions.IsAuthenticated]

    def get_serializer_class(self):
        if self.action == 'create':
            return  StockCreateSerializer
        return StockSerializer

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        instance = serializer.save(**{'customer': self.request.user})
        headers = self.get_success_headers(serializer.data)
        return  Response(StockSerializer(instance=instance).data,
                         status=status.HTTP_201_CREATED, headers=headers)

    def list(self, request, *args, **kwargs):
        queryset = Stock.objects.filter(customer= self.request.user)
        page = self.paginate_queryset(queryset)

        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)




