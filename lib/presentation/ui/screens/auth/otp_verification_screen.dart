import 'dart:async';
import 'dart:developer';
import 'package:e_commerce/presentation/state_holders/read_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../state_holders/auth_controller.dart';
import '../../../state_holders/email_verification_controller.dart';
import '../../../state_holders/otp_verification_controller.dart';
import '../../utility/app_colors.dart';
import '../../utility/image_assets.dart';
import 'package:get/get.dart';

import '../main_bottom_nav_screen.dart';
import 'complete_profile_screen.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;

  const OTPVerificationScreen({super.key, required this.email});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  //otp controller
  final TextEditingController _otpTEController = TextEditingController();
  bool otpControllerAndReadProfileInProgress=false;
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  //flag for Resend button
  bool isCountDownFinished = false;

  //countdown timer
  int timeInSecond = 120;
  Timer? _timer;
  late int _start;

  void startTimer() {
    _start = timeInSecond;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          isCountDownFinished =
              true;
          timer.cancel();
          if (mounted) {
            setState(() {});
          }
        } else {
          _start--;
          if (mounted) {
            setState(() {});
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Center(
                child: SvgPicture.asset(
                  ImageAssets.craftyBayLogoSVG,
                  width: 100,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Enter OTP Code",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 24),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "A 6 Digit OTP Code has been Sent",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey,
                    ),
              ),
              const SizedBox(
                height: 24,
              ),
              PinCodeTextField(
                controller: _otpTEController,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  activeColor: AppColors.primaryColor,
                  inactiveColor: AppColors.primaryColor,
                  selectedColor: Colors.green,
                ),
                animationDuration: Duration(milliseconds: 300),
                // backgroundColor: Colors.blue.shade50,
                enableActiveFill: true,
                // errorAnimationController: errorController,
                // controller: textEditingController,
                onCompleted: (v) {},
                onChanged: (value) {},
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");

                  return true;
                },
                appContext: context,
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: GetBuilder<OtpVerificationController>(
                    builder: (controller) {

                  if (otpControllerAndReadProfileInProgress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                  }

                  return ElevatedButton(
                    onPressed: () {
                      if(!(controller.otpVerificationInProgress && Get.find<ReadProfileController>().getProductInProgress)){
                        otpControllerAndReadProfileInProgress = true;
                      }
                      verifyOtp(controller);
                    },
                    child: const Text("Next"),
                  );
                }),
              ),
              const SizedBox(
                height: 24,
              ),
              RichText(
                  text: TextSpan(
                      style: const TextStyle(color: Colors.grey),
                      children: [
                    const TextSpan(text: 'This code will expire in'),
                    TextSpan(
                      text: ' ${_start}s',
                      style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ])),
              GetBuilder<EmailVerificationController>(
                builder: (controller) {
                  if(controller.emailVerificationInProgress){
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  return TextButton(

                    onPressed: isCountDownFinished
                        ? () {

                            startTimer();
                            isCountDownFinished = false;
                            _start =
                                timeInSecond;
                            if (mounted) {
                              setState(() {});
                            }
                            verifyEmail(controller);
                          }
                        : null,
                    style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColor),
                    child: const Text('Resend'),
                  );
                }
              ),
            ],
          ),
        ),
      )),
    );
  }

  //otp verification method, trigger by button click
  Future<void> verifyOtp(OtpVerificationController controller) async {
    final response =
        await controller.verifyOtp(widget.email, _otpTEController.text.trim());

          Future.delayed(const Duration(seconds:1)).then((value) async {

          if (response) {
            final responseCompleteProfile = await Get.find<ReadProfileController>().isProfileCompleted();

            print("Enter response condition");
            if(!responseCompleteProfile){
              print("inside product details - sharedPreference: ${AuthController.isProfileCompleted}");
              Get.offAll(()=>const CompleteProfileScreen());
            }else{
              Get.offAll(() => const MainBottomNavScreen());
            }

          } else {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('otp verification failed! try again'),
                ),
              );
            }
          }
        });


  }

  // resend otp by previous emailVerification method, trigger by Resend button
  Future<void> verifyEmail(EmailVerificationController controller) async {
    final response =
    await controller.verifyEmail(widget.email); //bool value return
    if (response) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Otp send by resend button'),
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Otp resend failed, try again'),
          ),
        );
      }
    }
  }
}
