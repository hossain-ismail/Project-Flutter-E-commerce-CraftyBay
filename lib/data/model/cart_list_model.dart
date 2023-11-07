import 'package:e_commerce/data/model/product.dart';

import 'cart_data.dart';
class CartListModel {
  String? msg;
  List<CartData>? data;

  CartListModel({this.msg, this.data});

  CartListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <CartData>[];
      json['data'].forEach((v) {
        data!.add(CartData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class CartData {
  int? id;
  String? email;
  int? productId;
  String? color;
  String? size;
  String? createdAt;
  String? updatedAt;
  Product? product; //import Product class
  // int numberOfItems =1;
  int? quantity;

  CartData(
      {this.id,
        this.email,
        this.productId,
        this.color,
        this.size,
        this.createdAt,
        this.updatedAt,
         this.quantity,
        this.product});


  CartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    productId = json['product_id'];
    color = json['color'];
    size = json['size'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    quantity=int.tryParse(json['qty'] ?? 1); //string to int parse
    product = Product.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['email'] = email;
    data['product_id'] = productId;
    data['color'] = color;
    data['size'] = size;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['product'] = product;
    return data;
  }
}

