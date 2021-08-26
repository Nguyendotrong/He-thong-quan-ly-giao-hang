from django.shortcuts import render
from django.views import View
from oauth2_provider.models import Application
from rest_framework import viewsets, permissions, status,generics
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.parsers import MultiPartParser
from .serializers import *


class Index(View):
    def get(self, request):
        o = Application.objects.get(pk=1)

        return render(request, template_name="index.html", context={"oauth2": o})


class UserViewSet(viewsets.ViewSet, generics.CreateAPIView, generics.RetrieveAPIView):
    queryset = User.objects.filter(is_active=True)
    serializer_class = UserSerializer
    parser_classes = [MultiPartParser,]

    def get_permissions(self):
        if  self.action == 'retrieve':
            return [permissions.IsAuthenticated()]

        return [permissions.AllowAny()]


class PostViewSet(viewsets.ModelViewSet):
    queryset = Post.objects.filter(active=True)
    serializer_class = PostSerializer
    # permission_classes = [permissions.IsAuthenticated]


    # def get_permissions(self):
    #
    #     if self.action == 'list':
    #         return [permissions.AllowAny()]
    #
    #     return [permissions.IsAuthenticated()]

    @action(methods=['post'], detail=True, url_path='hide-post',
            url_name='hide-post')
    def hide_post(self, reuqest, pk):
        try:
            post = Post.objects.get(pk=pk)
            post.active = False
            post.save()
        except post.DoesNotExits:
            return Response(status=status.HTTP_400_BAD_REQUEST)

        return Response(data=PostSerializer(post,context={'request':reuqest}).data,status=status.HTTP_200_OK)


