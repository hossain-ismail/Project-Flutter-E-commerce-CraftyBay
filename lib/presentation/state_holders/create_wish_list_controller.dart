import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class CreateWishListController extends GetxController{
  bool _createWishListInProgress = false;
  String _message ='';



  bool get getCreateWishListInProgress =>_createWishListInProgress;
  String get message => _message;



  Future<bool> getCreateWishList(int productId) async{
    _createWishListInProgress=true;
    update();
    final  NetworkResponse response = await NetworkCaller.getRequest(Urls.getCreateWishList(productId));
    _createWishListInProgress=false;
    update();
    if(response.isSuccess){
      print('Creating wish list is successful');
      Get.snackbar('Success',
        'Creating wish list is successful',
        snackPosition: SnackPosition.BOTTOM,

      );

      return true;
    } else{

      _message = 'get cart list failed! Try again';
      return false;
    }


  }
}