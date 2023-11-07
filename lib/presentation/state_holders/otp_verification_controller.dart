import 'package:get/get.dart';
import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
import 'auth_controller.dart';

class OtpVerificationController extends GetxController {
  bool _otpVerificationInProgress = false;
  String _message = '';
  bool get otpVerificationInProgress => _otpVerificationInProgress;
  String get message => _message;


  Future<bool> verifyOtp(String email, String otp) async {
    _otpVerificationInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.verifyOtp(email, otp),isLogin:true);

    _otpVerificationInProgress = false;
    update();
    if (response.isSuccess) {
      AuthController.setAccessToken(response.responseJson?['data']);
      return true;
    } else {
      _message = response.responseJson?['msg'] ?? ' ';
      print('when failed : ${response.responseJson?['msg'] ?? ' '}');
      return false;
    }
  }
}
