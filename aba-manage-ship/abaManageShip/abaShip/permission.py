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


class PermissionViewDetailAuction(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request,view)\
            and request.user.has_perm('abaShip.view_detail_auction')

class PermissionViewListAuctionOnPost(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view)\
                and request.user.has_perm('abaShip.view_list_auction_on_post')

class PermissionViewListAuctionOfShipper(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view)\
                and request.user.has_perm('abaShip.view_list_auction_of_shipper')


class PermissionAuction(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request,view)\
                and request.user.has_perms(['abaShip.change_auction','abaShip.delete_auction', 'abaShip.add_auction'])


class PermissionViewStock(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaShip.view_stock'])

class PermissionAddAuctionIntoPost(IsAuthenticated):
    def has_permission(self, request, view):
        return super(PermissionAddAuctionIntoPost, self).has_permission(request,view)\
                and request.user.has_perms(['abaShip.add_auction_into_post'])


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


class PermissionUpDateStatusOrder(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request,view)\
            and request.user.has_perm('abaShip.update_status_order')


class PermissionViewNotification(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaShip.view_notification'])


class PermissionViewRatingShipper(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaShip.view_rate'])


class PermissionRatingShipper(IsAuthenticated):
    def has_permission(self, request, view):
        return super().has_permission(request, view) \
               and request.user.has_perms(['abaShip.change_rate', 'abaShip.delete_rate', 'abaShip.add_rate'])

