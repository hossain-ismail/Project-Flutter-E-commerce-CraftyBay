import 'package:e_commerce/data/model/network_response.dart';
import 'package:e_commerce/data/model/product_model.dart';
import 'package:e_commerce/data/services/network_caller.dart';
import 'package:e_commerce/data/utility/urls.dart';
import 'package:get/get.dart';

class ProductListController extends GetxController {

  bool _getProductInProgress = false;
  ProductModel _productModel = ProductModel();
  String _errorMessage = '';

  //getter method
  bool get getProductInProgress => _getProductInProgress;
  ProductModel get productModel => _productModel;
  String get errorMessage => _errorMessage;

  //method for get data from ListProductByCategory
  Future<bool> getProductsByCategory(int categoryId) async {
    _getProductInProgress = true;
    update();
    //api fetch
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getProductByCategory(categoryId));
    _getProductInProgress = false;
    if (response.isSuccess) {
      _productModel = ProductModel.fromJson(response.responseJson ?? {});

      update();
      return true;
    } else {
      _errorMessage = "Product list data fetch failed! tray again";
      update();
      return false;
    }
  }

  void setProduct(ProductModel productModel){
    _productModel=productModel;
    update();
  }
}
