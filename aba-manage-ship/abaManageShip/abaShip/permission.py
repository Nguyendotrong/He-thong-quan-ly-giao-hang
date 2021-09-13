from rest_framework.permissions import IsAuthenticated, IsAdminUser, OR

class PermissionViewUser(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaShip.view_user',])

class PermissionChangeUser(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(self,request,view)\
            and request.user.has_perms(['abaShip.change_user'])



class PermissionViewPost(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request,view)\
                and request.user.has_perms(['abaShip.view_post',])


class PermissionPost(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request,view)\
                and request.user.has_perms(['abaShip.change_post','abaShip.delete_post', 'abaShip.add_post'])


class PermissionViewAution(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request,view)\
            and request.user.has_perms(['abaShip.view_auction'])

class PermissionAuction(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request,view)\
                and request.user.has_perms(['abaShip.change_auction','abaShip.delete_auction', 'abaShip.add_auction'])


class PermissionViewStock(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaShip.view_stock'])


class PermissionStock(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaShip.change_stock', 'abaShip.delete_stock', 'abaShip.add_stock'])


class PermissionViewIdCard(IsAuthenticated):

    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaShip.view_idcard', ])


class PermissionIdCard(IsAuthenticated):

    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaShip.change_idcard','abaShip.add_idcard', 'abaShip.delete_idcard' ])


class PermissionViewImageItem(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaShip.view_imageitem'])


class PermissionImageItem(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaShip.change_imageitem', 'abaShip.delete_imageitem', 'abShip.add_imageitem'])


class PermissionViewOrderShip(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaShip.view_ordership'])


class PermissionOrderShip(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaShip.change_ordership', 'abaShip.delete_ordership', 'abaShip.add_ordership'])


class PermissionViewOrderShipDetail(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaShip.view_ordershipdetail'])


class PermissionOrderShipDetail(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaShip.change_ordershipdetail', 'abaShip.delete_ordershipdetail', 'abaShip.add_ordershipdetail'])


class PermissionViewNotification(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaShip.view_notification'])


class PermissionViewCommentShipper(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaShip.view_auction'])


class PermissionCommentShipper(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaShip.change_commentshipper', 'abaShip.delete_commentshipper', 'abShip.add_commentshipper'])

