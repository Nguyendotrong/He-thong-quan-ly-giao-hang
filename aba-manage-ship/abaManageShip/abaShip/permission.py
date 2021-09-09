from rest_framework.permissions import IsAuthenticated, IsAdminUser, OR

class PermissionUser(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaship.view_user','abaship.change_user'])


class PermissionViewPost(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request,view)\
                and request.user.has_perms(['abaship.view_post',])


class PermissionPost(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request,view)\
                and request.user.has_perms(['abaship.change_post','abaship.delete_post', 'abship.add_post'])


class PermissionViewAution(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request,view)\
            and request.user.has_perms(['abaship.view_auction'])

class PermissionAuction(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request,view)\
                and request.user.has_perms(['abaship.change_auction','abaship.delete_auction', 'abship.add_astockuction'])


class PermissionViewStock(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaship.view_stock'])


class PermissionStock(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaship.change_stock', 'abaship.delete_stock', 'abship.add_stock'])


class PermissionViewIdCard(IsAuthenticated):

    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaship.view_idcard', ])


class PermissionIdCard(IsAuthenticated):

    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaship.change_idcard','abaship.add_idcard', 'abaship.delete_idcard' ])


class PermissionViewImageItem(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaship.view_imageitem'])


class PermissionImageItem(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaship.change_imageitem', 'abaship.delete_imageitem', 'abship.add_imageitem'])


class PermissionViewOrderShip(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaship.view_ordership'])


class PermissionOrderShip(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaship.change_ordership', 'abaship.delete_ordership', 'abship.add_ordership'])


class PermissionViewOrderShipDetail(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaship.view_ordershipdetail'])


class PermissionOrderShipDetail(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaship.change_ordershipdetail', 'abaship.delete_ordershipdetail', 'abship.add_ordershipdetail'])


class PermissionViewNotification(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaship.view_notification'])


class PermissionViewCommentShipper(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaship.view_auction'])


class PermissionCommentShipper(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaship.change_commentshipper', 'abaship.delete_commentshipper', 'abship.add_commentshipper'])

