import 'package:e_commerce/data/model/product_review_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
class ProductReviewGetController extends GetxController{
  bool _productReviewInProgress = false;
  String _errorMessage ='';
  ProductReviewModel _productReviewModel = ProductReviewModel();

  List<ProductReviewModel>review=[];
  //getter method
  bool get productReviewInProgress =>_productReviewInProgress;
  String get getErrorMessage => _errorMessage;
  ProductReviewModel get productReviewModel => _productReviewModel;


  //method for check is user SignedIn or not
  Future<bool> getProductReview(int productId) async{
    _productReviewInProgress=true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(Urls.getProductReview(productId));


    _productReviewInProgress=false;
    print("ProductId in Get Controller is : $productId");

    if(response.isSuccess){
      _productReviewModel=ProductReviewModel.fromJson(response.responseJson ?? {});
      print("length inside operation is ${_productReviewModel.data!.length}");
      update();
      return true;
    } else{
      Get.snackbar('Failed',
        'Review Loading Error',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
      );
      _errorMessage = 'Add to cart failed! Try again';
      update();
      return false;
    }


  }

}