from django.contrib.auth import logout
from rest_framework import viewsets, generics, permissions, status
from rest_framework.decorators import action
from rest_framework.parsers import MultiPartParser
from rest_framework.response import Response

from ..models import User
from ..serializers import UserRegisterSerializer, UserSerializer


class CustomerViewSet(viewsets.ViewSet, generics.CreateAPIView,generics.ListAPIView):
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