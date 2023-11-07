import 'package:e_commerce/data/model/network_response.dart';
import 'package:e_commerce/data/model/product_model.dart';
import 'package:e_commerce/data/services/network_caller.dart';
import 'package:e_commerce/data/utility/urls.dart';
import 'package:get/get.dart';

class SpecialProductController extends GetxController {

  bool _getSpecialProductInProgress = false;
  ProductModel _specialProductModel = ProductModel();
  String _errorMessage = '';

  //getter method
  bool get getSpecialProductInProgress => _getSpecialProductInProgress;
  ProductModel get specialProductModel => _specialProductModel;
  String get errorMessage => _errorMessage;

  //method for get data from SpecialProduct category
  Future<bool> getSpecialProduct() async {
    _getSpecialProductInProgress = true;
    update();
    //api fetch
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getProductByRemarks('special'));
    _getSpecialProductInProgress = false;
    if (response.isSuccess) {
      _specialProductModel = ProductModel.fromJson(response.responseJson ?? {});

      update();
      return true;
    } else {
      _errorMessage = "SpecialProduct fetch failed! tray again";
      update();
      return false;
    }
  }
}
