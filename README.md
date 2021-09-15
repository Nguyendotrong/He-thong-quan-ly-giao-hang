# he-thong-quan-ly-giao-hang
ABASHIP DELIVERY MANAGEMENT SYSTEM.

Design Database and  develop API for system functions using Python Django. Delivery by auction shipping.
- Language: Python.
- Database: MySql.
- Tech: Python Django Restfull API framework.
- Functions:
    + Customer has permission: Create and view self-created posts, view shipper info, view shipper auctions, choose a winner shipper, rate shipper after the shipper has shipped.
    + Shipper has permission: See posts that don't have an auction winner,  Create auction on posts, Confirms that the order has been completed
- Description:
     + Using Model to create class for objects and map down to database.
     + Using Serializer to convert data.
     + Using ViewSet or Generics or ModelViewSet and overide method to create API about list, detail, update and delete objects such as: , Shipper, Auction, Post,                      CommentShiper.
     + Register User. Authentication by OAuth2.
     + ...
