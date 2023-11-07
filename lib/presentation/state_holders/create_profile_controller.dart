import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/model/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class CreateProfileController extends GetxController {
  bool _createProfileInProgress = false;
  String _message = '';


  bool get getCreateProfileInProgress => _createProfileInProgress;

  String get message => _message;


  Future<bool> getCreateProfile(String cus_name, String cus_add,String cus_city,
      String cus_state,String cus_postcode, String cus_country,String cus_phone,
      String cus_fax,String ship_name,String ship_add,String ship_city,
      String ship_state,String ship_postcode,String ship_country,String ship_phone,
     ) async {
    _createProfileInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller.postRequest(
      Urls.createProfile,
      {

        "cus_name": cus_name,
        "cus_add": cus_add,
        "cus_city": cus_city,
        "cus_state": cus_state,
        "cus_postcode": cus_postcode,
        "cus_country": cus_country,
        "cus_phone": cus_phone,
        "cus_fax": cus_fax,
        "ship_name": ship_name,
        "ship_add": ship_add,
        "ship_city": ship_city,
        "ship_state": ship_state,
        "ship_postcode": ship_postcode,
        "ship_country": ship_country,
        "ship_phone": ship_phone,
      },
    );
    _createProfileInProgress = false;
    update();
    if (response.isSuccess) {
      Get.snackbar('Success', 'Profile has been created',
          snackPosition: SnackPosition.BOTTOM);
      return true;
    } else {
      _message = 'Add to cart failed! Try again';
      Get.snackbar(
        'Failed',
        'Error, Profile is not created',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
      );
      return false;
    }
  }
}
