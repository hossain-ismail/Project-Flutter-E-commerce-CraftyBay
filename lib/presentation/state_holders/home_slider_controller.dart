import 'package:get/get.dart';
import '../../data/model/network_response.dart';
import '../../data/model/slider_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
class HomeSliderController extends GetxController{
  bool _getHomeSliderInProgress = false;
  SliderModel _sliderModel = SliderModel();
  SliderModel get sliderModel => _sliderModel;
  String _message = '';
  bool get getHomeSliderInProgress => _getHomeSliderInProgress;
  String get message => _message;
  Future<bool> getHomeSlider()async{
    _getHomeSliderInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(Urls.getHomeSlider);
    _getHomeSliderInProgress = false;
    if(response.isSuccess){
      _sliderModel=SliderModel.fromJson(response.responseJson ?? {});
      update();
      return true;
    } else {
      _message = 'Sliders data fetch failed!';
      update();
      return false;
    }

  }
}