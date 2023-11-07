import 'package:shared_preferences/shared_preferences.dart';
class AuthController {
  static String? _accessToken;
  static bool ? _profileCompleted;

  static String? get accessToken => _accessToken;

  static bool? get profileCompleted => _profileCompleted;

  //set value to SharedPreferences
  static Future<void> setAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('access-toke', token);
    _accessToken = token;
  }

  //set profile complete bool value
  static Future<void> setIsProfileComplete(bool profile) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('profile-complete', profile);
    _profileCompleted = profile;
  }


  //get value from SharedPreferences
  static Future<void> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _accessToken = sharedPreferences
        .getString('access-toke');
  }

  //get profile complete bool value
  static Future<bool?> getIsProfileComplete() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _profileCompleted = sharedPreferences.getBool('profile-complete');
    return _profileCompleted;
  }

  //clear the SharedPreferences data
  static Future<void> clear() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

//check the instance member has data or not to confirm user is valid or not
  static Future<bool> get isLoggedIn async {
    await getAccessToken();

    return _accessToken != null;
  }

  //check user profile is completed or not
  static bool? get isProfileCompleted {
    return _profileCompleted ?? false;
  }
}
