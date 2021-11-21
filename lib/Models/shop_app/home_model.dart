class HomeModel {
  bool? status;
  String? message;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? new HomeDataModel.fromJson(json['data']) : null;
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];
  String? ad;

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      json['banners'].forEach(
        (element) => banners.add(BannerModel.fromJson(element)),
      );
    }
    if (json['products'] != null) {
      json['products'].forEach(
        (element) => products.add(ProductModel.fromJson(element)),
      );
    }
  }
}

class BannerModel {
  late int id;
  String image =
      'https://previews.123rf.com/images/yummybuum/yummybuum1903/yummybuum190300026/121811230-empty-white-box-cardboard-cubic-cosmetic-box-blank-package-with-shadows-medicine-product-packaging-i.jpg';

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int? id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  String image =
      'https://previews.123rf.com/images/yummybuum/yummybuum1903/yummybuum190300026/121811230-empty-white-box-cardboard-cubic-cosmetic-box-blank-package-with-shadows-medicine-product-packaging-i.jpg';
  late String name;
  bool? in_favorite;
  bool? in_cart;
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    in_favorite = json['in_favorite'];
    in_cart = json['in_cart'];
  }
}
