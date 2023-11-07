import 'package:e_commerce/data/model/product_details.dart';
import 'package:e_commerce/data/model/product_details_model.dart';
import 'package:get/get.dart';
import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
class ProductDetailsController extends GetxController{
  bool _getProductDetailsInProgress = false;

 ProductDetails _productDetails = ProductDetails();

  String _errorMessage = '';


  final List<String> _availableColor = [];
  List<String> _availableSizes= [];
  //getter method
  bool get getProductDetailsInProgress => _getProductDetailsInProgress;
  ProductDetails get productDetails => _productDetails;

  String get errorMessage => _errorMessage;
  List<String> get availableColor => _availableColor;
  List<String> get availableSizes => _availableSizes;

  Future<bool> getProductDetails(int productId) async {
    _getProductDetailsInProgress = true;
    update();
    //api fetch
    final NetworkResponse response =
    await NetworkCaller.getRequest(Urls.getProductDetails(productId));
    _getProductDetailsInProgress = false;

    if (response.isSuccess) {
      _productDetails = ProductDetailsModel.fromJson(response.responseJson ?? {}).data!.first;

      _convertStringToColor(_productDetails.color ?? '');
      _convertStringToSizes(_productDetails.size ?? '');
      update();
      return true;
    } else {
      _errorMessage = "Fetch product details has been failed! tray again";
      update();
      return false;
    }
  }

  void _convertStringToColor (String color){
    _availableColor.clear();
    final List<String> splittedColors = color.split(',');
    for(String c in splittedColors){
      if(c.isNotEmpty){
        _availableColor.add(c);
      }
    }
  }

  //add string size to list
  void _convertStringToSizes(String size){
      _availableSizes=size.split(',');
  }
}