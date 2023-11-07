import 'package:flutter/material.dart';

import '../presentation/ui/utility/app_colors.dart';

class Themes{
  final lightTheme=  ThemeData(

    primarySwatch: MaterialColor(AppColors.primaryColor.value, AppColors().color),

    inputDecorationTheme: const InputDecorationTheme(

      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      enabledBorder: OutlineInputBorder(

          borderSide: BorderSide(color: AppColors.primaryColor)
      ),
      border:  OutlineInputBorder(

          borderSide: BorderSide(color: AppColors.primaryColor)
      ),
      focusedBorder: OutlineInputBorder(

          borderSide: BorderSide(color: AppColors.primaryColor)
      ),
    ),

    //Elevated Button Style
    elevatedButtonTheme:  ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          textStyle: const TextStyle(fontSize: 16,letterSpacing: 0.5,fontWeight: FontWeight.w600,),
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
        )
    ),
  );


  final darkTheme= ThemeData(
    brightness: Brightness.dark,

    primarySwatch: MaterialColor(AppColors.primaryColor.value, AppColors().color),


    //TextFormField style
    inputDecorationTheme: const InputDecorationTheme(

      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      enabledBorder: OutlineInputBorder(

          borderSide: BorderSide(color: AppColors.primaryColor)
      ),
      border:  OutlineInputBorder(

          borderSide: BorderSide(color: AppColors.primaryColor)
      ),
      focusedBorder: OutlineInputBorder(

          borderSide: BorderSide(color: AppColors.primaryColor)
      ),
    ),

    //Elevated Button Style
    elevatedButtonTheme:  ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          textStyle: const TextStyle(fontSize: 16,letterSpacing: 0.5,fontWeight: FontWeight.w600,),
          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8)),
        )
    ),
  );
}