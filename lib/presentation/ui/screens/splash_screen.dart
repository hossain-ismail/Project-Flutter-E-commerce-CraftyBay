import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../state_holders/auth_controller.dart';
import '../utility/image_assets.dart';
import 'main_bottom_nav_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToNextScreen();
  }

  Future<void> goToNextScreen() async {

    await AuthController.getAccessToken();
    Future.delayed(const Duration(seconds: 3)).then((value) {

      Get.offAll(()=>const MainBottomNavScreen());

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          const Spacer(),

          Center(
            child: SvgPicture.asset(
              ImageAssets.craftyBayLogoSVG,
              width: 100,
            ),
          ),
          //take all the available space
          const Spacer(),
          const CircularProgressIndicator(),
          const Text("Version 1.0.0"),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
