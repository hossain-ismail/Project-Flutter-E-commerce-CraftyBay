import 'package:e_commerce/data/model/network_response.dart';
import 'package:e_commerce/data/model/product_model.dart';
import 'package:e_commerce/data/services/network_caller.dart';
import 'package:e_commerce/data/utility/urls.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {

  bool _getPopularProductInProgress = false;

  ProductModel _popularProductModel = ProductModel();

  String _errorMessage = '';

  //getter method
  bool get getPopularProductInProgress => _getPopularProductInProgress;
  ProductModel get popularProductModel => _popularProductModel;
  String get errorMessage => _errorMessage;

  Future<bool> getPopularProduct() async {
    _getPopularProductInProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.getProductByRemarks('popular'));
    _getPopularProductInProgress = false;

    if (response.isSuccess) {
      _popularProductModel = ProductModel.fromJson(response.responseJson ?? {});

      update();
      return true;
    } else {
      _errorMessage = "Popular Product fetch failed! tray again";
      update();
      return false;
    }
  }
}
