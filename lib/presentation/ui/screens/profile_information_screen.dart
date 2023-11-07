import 'package:e_commerce/presentation/state_holders/read_profile_controller.dart';
import 'package:e_commerce/presentation/ui/screens/auth/complete_profile_screen.dart';
import 'package:e_commerce/presentation/ui/screens/purchased_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/read_profile_model.dart';

class ProfileInformationScreen extends StatelessWidget {
  const ProfileInformationScreen({super.key});

  TextStyle style() {
    return const TextStyle(fontSize: 17);
  }

  @override
  Widget build(BuildContext context) {
    ReadProfileModel profileInformation =
        Get.find<ReadProfileController>().readProfileModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                const Text(
                  'User Details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 30, right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Customer Information",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Name : ${profileInformation.data!.cusName}",
                            style: style(),
                          ),
                          Text("Address : ${profileInformation.data!.cusAdd}",
                              style: style()),
                          Text("City : ${profileInformation.data!.cusCity}",
                              style: style()),
                          Text("State : ${profileInformation.data!.cusState}",
                              style: style()),
                          Text(
                              "PostCode : ${profileInformation.data!.cusPostcode}",
                              style: style()),
                          Text(
                              "Country : ${profileInformation.data!.cusPostcode}",
                              style: style()),
                          Text(
                              "Phone Number : ${profileInformation.data!.cusPhone}",
                              style: style()),
                          Text("Fax : ${profileInformation.data!.cusFax}",
                              style: style()),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "Shipping Information",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text("Name : ${profileInformation.data!.shipName}",
                              style: style()),
                          Text("Address : ${profileInformation.data!.shipAdd}",
                              style: style()),
                          Text("City : ${profileInformation.data!.shipCity}",
                              style: style()),
                          Text("State : ${profileInformation.data!.shipState}",
                              style: style()),
                          Text(
                              "PostCode : ${profileInformation.data!.shipPostcode}",
                              style: style()),
                          Text(
                              "Country : ${profileInformation.data!.shipCountry}",
                              style: style()),
                          Text(
                              "Phone Number : ${profileInformation.data!.shipPhone}",
                              style: style()),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {
                                  Get.to(() => const CompleteProfileScreen());
                                },
                                child: Text(
                                  "Update",
                                  style: style(),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Get.to(()=>const PurchasedHistory());
                    },
                    child: const Text(
                      "Purchased history",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
