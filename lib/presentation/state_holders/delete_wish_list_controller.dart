import 'package:e_commerce/data/model/product_details.dart';
import 'package:e_commerce/data/model/product_details_model.dart';
import 'package:get/get.dart';
import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
class DeleteWishListController extends GetxController{
  bool _getDeleteWishListInProgress = false;




  bool get getDeleteWishListInProgress => _getDeleteWishListInProgress;


  Future<bool> getRemoveWishListProduct(int productId) async {
    _getDeleteWishListInProgress = true;
    update();
    //api fetch
    final NetworkResponse response =
    await NetworkCaller.getRequest(Urls.getRemoveWishList(productId));
    _getDeleteWishListInProgress = false;

    if (response.isSuccess) {
      Get.snackbar('Delete', 'Item Deleted');
      update();
      return true;
    } else {
      Get.snackbar('Fail', 'Item Deleted Fail, tray again');
      update();
      return false;
    }
  }

}