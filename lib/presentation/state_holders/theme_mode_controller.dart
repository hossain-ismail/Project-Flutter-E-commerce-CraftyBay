import 'package:e_commerce/presentation/state_holders/auth_controller.dart';
import 'package:flutter/material.dart';
// its not part of getx
class ThemeModeController{
  ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.light);
  void changeThemeMode(ThemeMode mode){
    themeMode.value=mode;
  }
  void toggleThemeMode(){
    if(themeMode.value==ThemeMode.light){
      themeMode.value=ThemeMode.dark;
    }else{
      themeMode.value=ThemeMode.light;
    }

  }


}