import 'package:e_commerce/data/model/cart_list_model.dart';
import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class CartListController extends GetxController{
  bool _getCartListInProgress = false;
  String _message ='';
  CartListModel _cartListModel = CartListModel();
  double _totalPrice=0;
  //getter method
  bool get getCartListInProgress =>_getCartListInProgress;
  String get message => _message;
  CartListModel get cartListModel => _cartListModel;
  double get totalPrice => _totalPrice;
  //method for check is user SignedIn or not
  Future<bool> getCartList() async{
    _getCartListInProgress=true;
    update();
  final  NetworkResponse response = await NetworkCaller.getRequest(Urls.getCartList);
    _getCartListInProgress=false;

    if(response.isSuccess){
      _cartListModel= CartListModel.fromJson(response.responseJson!);
      _calculateTotalPrice();
      update();
    return true;
    } else{
      _message = 'get cart list failed! Try again';

      update();
      return false;
    }


  }
  void changeItem(int cartId, int noOfItems){
    _cartListModel.data?.firstWhere((cartData) => cartData.id==cartId).quantity=noOfItems;

    _calculateTotalPrice();
  }
  void _calculateTotalPrice(){
    _totalPrice=0;
    for(CartData data in _cartListModel.data?? []){
      _totalPrice += ((data.quantity??1) * (double.tryParse(data.product?.price?? '0')?? 0));
    }
    update();
  }


  Future<bool> removeFromCart(int id) async{
    _getCartListInProgress=true;
    update();
    final  NetworkResponse response = await NetworkCaller.getRequest(Urls.removeFromCart(id));
    _getCartListInProgress=false;

    if(response.isSuccess){
      _cartListModel.data?.removeWhere((element) => element.productId==id);
      _calculateTotalPrice();
      update();
      return true;
    } else{
      _message = 'get cart list failed! Try again';

      update();
      return false;
    }


  }
}