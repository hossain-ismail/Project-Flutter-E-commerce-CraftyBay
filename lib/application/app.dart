import 'dart:async';
import 'package:e_commerce/application/state_holder_binder.dart';
import 'package:e_commerce/presentation/state_holders/theme_mode_controller.dart';
import 'package:flutter/material.dart';
import '../presentation/ui/screens/splash_screen.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../theme/theme_service.dart';
import '../theme/themes.dart';
final ThemeModeController themeModeController = ThemeModeController(); //global instance for the app, it could be situated in any page just make it before class start
class CraftyBay extends StatefulWidget {
  const CraftyBay({super.key});
    static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  @override
  State<CraftyBay> createState() => _CraftyBayState();
}

class _CraftyBayState extends State<CraftyBay> {

  late final StreamSubscription _connectivityStatusStream;
  @override
  void initState() {
    checkInitialInternetConnection();
    checkInternetConnectivityStatus();
    super.initState();
  }
  void checkInitialInternetConnection() async{
    final result = await Connectivity().checkConnectivity();
    handleConnectivityStates(result);
  }

  void checkInternetConnectivityStatus() {

    _connectivityStatusStream =  Connectivity().onConnectivityChanged.listen((status) {
      handleConnectivityStates(status);
    });
  }

  void handleConnectivityStates(ConnectivityResult status){

    if(status != ConnectivityResult.mobile && status != ConnectivityResult.wifi){
      print("Not Connected");

      Get.showSnackbar(const GetSnackBar(
        title: 'No internet',
        message: 'Please check your internet connectivity',
        isDismissible: false,
      ));
    }else{
      print("Connected");

      if(Get.isSnackbarOpen){
        Get.closeAllSnackbars();
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder(
      valueListenable: themeModeController.themeMode,
      builder: (context, themeMode,_) {
        return GetMaterialApp(
          navigatorKey: CraftyBay.globalKey,
          home: const SplashScreen(),
          initialBinding: StateHolderBinder(),

          themeMode: ThemeService().getThemeMode(),
          theme: Themes().lightTheme,

          darkTheme: Themes().darkTheme,
        );
      }
    );

  }

  @override
  void dispose() {
    _connectivityStatusStream.cancel();
    super.dispose();
  }
}
