import 'package:e_commerce/data/model/category_model.dart';
import 'package:e_commerce/data/model/network_response.dart';
import 'package:e_commerce/data/services/network_caller.dart';
import 'package:get/get.dart';

import '../../data/utility/urls.dart';

class CategoryController extends GetxController{
   bool _getCategoryInProgress = false;
   String _message = '';

  CategoryModel _categoryModel = CategoryModel();
  bool get getCategoryInProgress=>_getCategoryInProgress;
  String get message => _message;
  CategoryModel get categoryModel => _categoryModel;

  Future<bool> getCategories() async{
    _getCategoryInProgress=true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(Urls.getCategories);
    _getCategoryInProgress=false;
    if(response.isSuccess){
      _categoryModel=CategoryModel.fromJson(response.responseJson ?? {});
      update();
      return true;
    }else{
      _message='Category list data fetch failed';
      update();
      return false;

    }

  }

}