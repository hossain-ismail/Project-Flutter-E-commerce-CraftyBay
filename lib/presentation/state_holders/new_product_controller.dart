import 'package:e_commerce/data/model/network_response.dart';
import 'package:e_commerce/data/model/product_model.dart';
import 'package:e_commerce/data/services/network_caller.dart';
import 'package:e_commerce/data/utility/urls.dart';
import 'package:get/get.dart';

class NewProductController extends GetxController {

  bool _getNewProductInProgress = false;
  ProductModel _newProductModel = ProductModel();
  String _errorMessage = '';

  //getter method
  bool get getNewProductInProgress => _getNewProductInProgress;
  ProductModel get newProductModel => _newProductModel;
  String get errorMessage => _errorMessage;

  //method for get data from SpecialProduct category
  Future<bool> getNewProduct() async {
    _getNewProductInProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getProductByRemarks('new'));
    _getNewProductInProgress = false;
    if (response.isSuccess) {
      _newProductModel = ProductModel.fromJson(response.responseJson ?? {});

      update();
      return true;
    } else {
      _errorMessage = "New Product fetch failed! tray again";
      update();
      return false;
    }
  }
}
