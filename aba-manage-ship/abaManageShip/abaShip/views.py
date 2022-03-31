from django.contrib.auth import  logout
from django.shortcuts import render, redirect
from django.views import View
from oauth2_provider.models import Application
from rest_framework import viewsets, permissions, status, generics
from rest_framework.decorators import action
from rest_framework.exceptions import PermissionDenied
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser
from rest_framework.views import APIView
from django.conf import settings

from .serializers import *
from .view import *
from .permission import *
# from ..abaManageShip import settings


class Index(View):
    def get(self, request):
        o = Application.objects.get(pk=1)

        return render(request, template_name="index.html", context={"oauth2": o})


class UserViewSet(viewsets.GenericViewSet, generics.CreateAPIView,generics.ListAPIView, generics.UpdateAPIView):
    queryset = User.objects.filter(is_active=True)
    # serializer_class = UserSerializer
    parser_classes = [MultiPartParser, ]


    def get_serializer_class(self):
        if self.action == 'create':
            return UserRegisterSerializer
        return UserSerializer

    def get_permissions(self):
        if self.action == 'current-user':
            return [PermissionViewUser(),]
        elif self.action == 'update':
            return [PermissionChangeUser(),]
        else:
            return [permissions.AllowAny()]


    @action(methods=['get'], detail=False, url_path='current-user')
    def current_user(self, request):
        return Response(self.get_serializer(request.user).data)

    def list(self, request, *args, **kwargs):
        return Response(status=status.HTTP_404_NOT_FOUND)

    def create(self, request, *args, **kwargs):

        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        instance = serializer.save()
        headers = self.get_success_headers(instance)
        return Response(UserSerializer(instance).data, status=status.HTTP_201_CREATED, headers=headers)


    # http://127.0.0.1:8000/users/8/
    def update(self, request, *args, **kwargs):
        # print(type(kwargs.get('pk')))
        if str(request.user.id) == kwargs.get("pk"):
            return super().update(request, *args, **kwargs)
        raise PermissionDenied()

    @action(methods=["PATCH"], detail=False, url_path='change_password', name="change_password")
    def changePassword(self,request, *args, **kwargs):
        if str(request.user.id) == kwargs.get("pk"):
            pass

    @action(methods=["GET"], detail=False, url_path="logout", name="logout")
    def logout(self, request, *args, **kwargs):
        logout(request)
        if request.auth:
            request.auth.revoke()
        return Response(status=status.HTTP_200_OK)


class OauthInfo(APIView):
    def get(self,request):
        return Response(settings.OAUTH2_INFO, status=status.HTTP_200_OK)



class ImageItemViewSet(viewsets.ModelViewSet):
    queryset = ImageItem.objects.all()
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = ImageItemSerializer
    parser_classes = [MultiPartParser,]


    # def list(self, request, *args, **kwargs):
    #     queryset = ImageItem.objects.all()
    #
    #     page = self.paginate_queryset(queryset)
    #     if page is not None:
    #         serializer = self.get_serializer(page, many=True)
    #         return self.get_paginated_response(serializer.data)
    #
    #     serializer = self.get_serializer(queryset, many=True)
    #     return Response(serializer.data)

    # def get_serializer_class(self):
    #     # if (self.action == "create"):
    #     #     return ImageItemCreatSerializer
    #     return ImageItemViewSet

    # def create(self, request, *args, **kwargs):
    #     serializer = self.get_serializer(data=request.data)
    #     serializer.is_valid(raise_exception=True)
    #     self.perform_create(serializer)
    #     headers = self.get_success_headers(serializer.data)
    #     return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)
    #
    #     serializer = self.get_serializer(data=request.data)
    #     serializer.is_valid(raise_exception=True)
    #     instance = serializer.save(**{'customer': self.request.user})
    #     headers = self.get_success_headers(serializer.data)
    #     return Response(StockCreateSerializer(instance=instance).data,
    #                     status=status.HTTP_201_CREATED, headers=headers)