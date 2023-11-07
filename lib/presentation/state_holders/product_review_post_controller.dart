import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
class ProductReviewPostController extends GetxController{
  bool _productReviewInProgress = false;
  String _errorMessage ='';
  late int _productId;

  //getter method
  bool get productReviewInProgress =>_productReviewInProgress;
  String get getErrorMessage => _errorMessage;
  int get getProductId => _productId;

  Future<bool> postProductReview(String description,String rating) async{
    _productReviewInProgress=true;
    update();
    NetworkResponse response = await NetworkCaller.postRequest(Urls.postProductReview, {

      "description":description,
      "product_id":_productId,
      "rating":rating,
    },);
    _productReviewInProgress=false;
    update();

    if(response.isSuccess){
      print("post review inside isSuccess condition");
      Get.snackbar('Success',
          'Your Review has been added',
          snackPosition: SnackPosition.BOTTOM,);
      return true;

    } else{
      _errorMessage = 'Add to cart failed! Try again';
      Get.snackbar('Fail',
        'Your Review is not posted, tray again!',
        backgroundColor:Colors.red[200],
        snackPosition: SnackPosition.BOTTOM,);
      return false;
    }


  }
  //setter method to revive ProductId form different place
  void setProductId(int productId){
    _productId=productId;
  }
}