import 'package:e_commerce/presentation/state_holders/cart_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class DeleteCartListItemController extends GetxController{
  bool _getDeleteCartListInProgress = false;
  String _message ='';

  bool get getDeleteCartListInProgress =>_getDeleteCartListInProgress;
  String get message => _message;

  Future<bool> deleteCartListItem(int productId) async{
    _getDeleteCartListInProgress=true;
    update();
    final  NetworkResponse response = await NetworkCaller.getRequest(Urls.getDeleteCartListItem(productId));
    _getDeleteCartListInProgress=false;

    if(response.isSuccess){
      Get.find<CartListController>().getCartList();

      Get.snackbar(
        'Success',
        'Data has been Deleted',
        snackPosition: SnackPosition.BOTTOM,

      );
      update();
      return true;
    } else{
      _message = 'Data delete operation failed! Try again';
      Get.snackbar(
        'Failed',
        'Data delete operation failed',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,

      );
      update();
      return false;
    }


  }
}