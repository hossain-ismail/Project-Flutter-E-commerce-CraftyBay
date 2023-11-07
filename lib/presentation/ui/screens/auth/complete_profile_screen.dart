import 'package:e_commerce/presentation/state_holders/create_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../state_holders/read_profile_controller.dart';
import '../../utility/image_assets.dart';
import '../main_bottom_nav_screen.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController customerNameTEC = TextEditingController();
  final TextEditingController customerCityTEC = TextEditingController();
  final TextEditingController customerStateTEC = TextEditingController();
  final TextEditingController customerPostCodeTEC = TextEditingController();
  final TextEditingController customerCountryTEC = TextEditingController();
  final TextEditingController customerPhoneTEC = TextEditingController();
  final TextEditingController customerFaxTEC = TextEditingController();
  final TextEditingController customerAddressTEC = TextEditingController();
  final TextEditingController shippingNameTEC = TextEditingController();
  final TextEditingController shippingCityTEC = TextEditingController();
  final TextEditingController shippingStateTEC = TextEditingController();
  final TextEditingController shippingPostCodeTEC = TextEditingController();
  final TextEditingController shippingCountryTEC = TextEditingController();
  final TextEditingController shippingPhoneTEC = TextEditingController();
  final TextEditingController shippingAddressTEC = TextEditingController();
  bool isAddressSame = false;
  int customerMobileDigitNumber = 0;
  int shipMobileDigitNumber = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => const MainBottomNavScreen());
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
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
                      "Complete Profile",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text("Get Started with us with your details",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.grey)),
                    const SizedBox(
                      height: 4,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Shipping address Same as User Address'),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isAddressSame = !isAddressSame;
                            });
                          },
                          child: Icon(
                            isAddressSame
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),


                    customerDetails(),
                    const SizedBox(
                      height: 12,
                    ),

                    Visibility(
                      visible: !isAddressSame,
                      replacement: const SizedBox(),
                      child: shippingDetails(),
                    ),

                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<CreateProfileController>(
                          builder: (createProfileController) {
                        if (createProfileController
                            .getCreateProfileInProgress) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ElevatedButton(
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            userAndShippingAddressSame();
                            //post data to  api server
                            await createProfileController.getCreateProfile(
                              customerNameTEC.text,
                              customerAddressTEC.text,
                              customerCityTEC.text,
                              customerStateTEC.text,
                              customerPostCodeTEC.text,
                              customerCountryTEC.text,
                              customerPhoneTEC.text,
                              customerFaxTEC.text,
                              shippingNameTEC.text,
                              shippingAddressTEC.text,
                              shippingCityTEC.text,
                              shippingStateTEC.text,
                              shippingPostCodeTEC.text,
                              shippingCountryTEC.text,
                              shippingPhoneTEC.text,
                            );

                            //clear the controller
                            clearController();

                            await Get.find<ReadProfileController>()
                                .isProfileCompleted();
                            Get.offAll(() => const MainBottomNavScreen());
                          },
                          child: const Text("Complete"),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //customer Details information
  Widget customerDetails() {
    // int mobileDigitNumber=100;
    return Column(
      children: [
        // name
        TextFormField(
          controller: customerNameTEC,
          decoration: const InputDecoration(
            hintText: 'Your Name',
            prefixIcon: Icon(Icons.person),
          ),
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Name';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          controller: customerCityTEC,
          decoration: const InputDecoration(
            hintText: 'City',
           
          ),
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Enter City Name';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          controller: customerStateTEC,
          decoration: const InputDecoration(
            hintText: 'your State',
            
          ),
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Enter your State Name';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          controller: customerPostCodeTEC,
          decoration: const InputDecoration(
            hintText: 'Your PostCode',
          ),
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Enter your PostCode';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 12,
        ),

        TextFormField(
          controller: customerCountryTEC,
          decoration: const InputDecoration(
            hintText: 'Your Country Name',
          ),
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Enter Your Country Name';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 12,
        ),
        //mobile
        TextFormField(
          onChanged: (numberOfDigit) {
            customerMobileDigitNumber = numberOfDigit.length;
            setState(() {});
            print("Length : $customerMobileDigitNumber");
          },
          controller: customerPhoneTEC,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: 'Your Mobile Number',
            suffixText: '$customerMobileDigitNumber / 11',
            suffixStyle: customerMobileDigitNumber != 11
                ? TextStyle(
                    color: customerMobileDigitNumber > 11 ? Colors.red : Colors.black,fontSize: 16
                  )
                :  const TextStyle(color: Colors.green,fontSize: 16),
          ),
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Enter Mobile Number';
            }
            if (value!.length != 11) {
              return 'Enter 11 digit Mobile Number';
            }

            return null;
          },
        ),
        //fax
        const SizedBox(
          height: 12,
        ),

        TextFormField(
          controller: customerFaxTEC,
          decoration: const InputDecoration(
            hintText: 'Your Fax Number',
          ),
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Enter Your Fax Number';
            }
            return null;
          },
        ),

        const SizedBox(
          height: 12,
        ),
        //customer Address
        TextFormField(
          controller: customerAddressTEC,
          maxLines: 6,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            hintText: 'Enter your Address',
          ),
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Enter your Address';
            }
            return null;
          },
        ),
      ],
    );
  }

  //Shipping address
  Widget shippingDetails() {
    return Column(
      children: [
        //name
        TextFormField(
          controller: shippingNameTEC,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.person),
            hintText: 'Shipping Name',
          ),
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Enter shipping Name';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 12,
        ),
        //city
        TextFormField(
          controller: shippingCityTEC,
          decoration: const InputDecoration(
            hintText: 'Shipping City',
          ),
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Enter shipping City Name';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 12,
        ),
        //state
        TextFormField(
          controller: shippingStateTEC,
          decoration: const InputDecoration(
            hintText: 'shipping State',
          ),
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Enter shipping State Name';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 12,
        ),
        //postcode
        TextFormField(
          controller: shippingPostCodeTEC,
          decoration: const InputDecoration(
            hintText: 'shipping PostCode',
          ),
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Enter shipping PostCode';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 12,
        ),
        //country
        TextFormField(
          controller: shippingCountryTEC,
          decoration: const InputDecoration(
            hintText: 'shipping Country Name',
          ),
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Enter shipping Country Name';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 12,
        ),
        //mobile
        TextFormField(
          controller: shippingPhoneTEC,
          keyboardType: TextInputType.phone,
          onChanged: (numberOfDigit) {
            shipMobileDigitNumber = numberOfDigit.length;
            setState(() {});
            print("Length : $shipMobileDigitNumber");
          },
          decoration: InputDecoration(
            hintText: 'shipping Mobile Number',
            suffixText: '$shipMobileDigitNumber / 11',
            suffixStyle: shipMobileDigitNumber != 11
                ? TextStyle(
                color: shipMobileDigitNumber > 11 ? Colors.red : Colors.black,fontSize: 16
            )
                :  const TextStyle(color: Colors.green,fontSize: 16),
          ),
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Enter shipping Mobile Number';
            }
            if (value!.length != 11) {
              return 'Enter 11 digit Mobile Number';
            }

            return null;
          },
        ),
        const SizedBox(
          height: 12,
        ),
        //shipping Address
        TextFormField(
          controller: shippingAddressTEC,
          maxLines: 6,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            hintText: 'shipping Address',
          ),
          validator: (String? value) {
            if (value?.isEmpty ?? true) {
              return 'Enter shipping Address';
            }
            return null;
          },
        ),
      ],
    );
  }

//clear the controller
  void clearController() {
    customerNameTEC.clear();
    customerAddressTEC.clear();
    customerCityTEC.clear();
    customerStateTEC.clear();
    customerPostCodeTEC.clear();
    customerCountryTEC.clear();
    customerPhoneTEC.clear();
    customerFaxTEC.clear();
    shippingNameTEC.clear();
    shippingAddressTEC.clear();
    shippingCityTEC.clear();
    shippingStateTEC.clear();
    shippingPostCodeTEC.clear();
    shippingCountryTEC.clear();
    shippingPhoneTEC.clear();
  }

//user address and shipping address are same
  void userAndShippingAddressSame() {
    if (isAddressSame) {
      shippingNameTEC.text = customerNameTEC.text;
      shippingAddressTEC.text = customerAddressTEC.text;
      shippingCityTEC.text = customerCityTEC.text;
      shippingStateTEC.text = customerStateTEC.text;
      shippingPostCodeTEC.text = customerPostCodeTEC.text;
      shippingCountryTEC.text = customerCountryTEC.text;
      shippingPhoneTEC.text = customerPhoneTEC.text;
    }
  }
}
