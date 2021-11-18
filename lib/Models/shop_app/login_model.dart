class ShopLoginModel {
  bool? status;
  String? message;
  UserData? data;

  //Named constractor
  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  int? id;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  // named constractor
  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
