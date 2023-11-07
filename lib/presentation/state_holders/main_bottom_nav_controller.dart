import 'package:e_commerce/presentation/state_holders/auth_controller.dart';
import 'package:get/get.dart';

import '../ui/screens/auth/email_verification_screen.dart';
class MainBottomNavController extends GetxController{
  int currentSelectedIndex =0;
  void changeScreen(int index) async{
    if((index ==2 || index ==3)  && await AuthController.isLoggedIn){
      currentSelectedIndex = index;

    }else if(index ==0 || index ==1) {
      currentSelectedIndex = index;
    }else{
      Get.offAll(const EmailVerificationScreen());
    }

    update();
  }
  void backToHomeScreen(){
    changeScreen(0);
  }

}