import 'package:e_commerce/data/model/wish_list_model.dart';
import 'package:get/get.dart';

import '../../data/model/network_response.dart';
import '../../data/model/product.dart';
import '../../data/model/product_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class GetWishListDataController extends GetxController{
  bool _getWishListProductInProgress = false;
  WishListModel _wishListModel = WishListModel();
  String _errorMessage = '';

  //getter method
  bool get getProductInProgress => _getWishListProductInProgress;
  WishListModel get getWishListModel => _wishListModel;
  String get errorMessage => _errorMessage;

  //method for get data from WishList
  Future<bool> getWishListData() async {
    _getWishListProductInProgress = true;
    update();
    //api fetch
    final NetworkResponse response = await NetworkCaller.getRequest(Urls.productWishList);
      _getWishListProductInProgress = false;
      if (response.isSuccess) {
       _wishListModel = WishListModel.fromJson(response.responseJson ?? {});
        update();
        print("title print");
        print(_wishListModel.data?.map((e) => e.product?.title?? 'not found').toString());
        print("print productId");
        print(_wishListModel.data?.map((e) => e.productId).toString());
      return true;
    } else {
      _errorMessage = "Wish list data fetch failed! tray again";
      update();
      return false;
    }
  }

}