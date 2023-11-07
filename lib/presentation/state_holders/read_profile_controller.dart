

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/model/network_response.dart';
import '../../data/model/read_profile_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
import 'auth_controller.dart';

class ReadProfileController extends GetxController{
  bool _readProfileInProgress = false;
  ReadProfileModel _readProfileModel = ReadProfileModel();
  String _errorMessage = '';

  //getter method
  bool get getProductInProgress => _readProfileInProgress;
  ReadProfileModel get readProfileModel => _readProfileModel;
  String get errorMessage => _errorMessage;

  //method for get data from WishList
  Future<bool> getReadProfile(String token) async {
    _readProfileInProgress = true;
    update();
    //api fetch
    final NetworkResponse response = await NetworkCaller.getRequest(Urls.readProfile(token));
    _readProfileInProgress = false;
    if (response.isSuccess) {
      _readProfileModel=ReadProfileModel.fromJson(response.responseJson ?? {});

      update();

      return true;
    } else {
      _errorMessage = "Wish list data fetch failed! tray again";
      update();
      return false;
    }
  }
  Future<bool> isProfileCompleted() async{
    final response = await getReadProfile(AuthController.accessToken!);

    final String msg = "${_readProfileModel.msg}";

    final bool customerName = _readProfileModel.data?.cusName?.isNotEmpty?? false; // check there is customer name
    print("is there present customer name: $customerName");

    final bool dataCheckResponse= msg=="success" && customerName;

    if(response){
      print("inside isProfileCompleted dataCheckResponse is : $dataCheckResponse");
      if(dataCheckResponse) {
       await AuthController.setIsProfileComplete(dataCheckResponse);
        print("inside isProfileCompleted dataCheckResponse condition is : ${AuthController.isProfileCompleted}");
        update();
        return true;
      }
    }
    AuthController.setIsProfileComplete(dataCheckResponse);
    update();
    return false;
  }
}