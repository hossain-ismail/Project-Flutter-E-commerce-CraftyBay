import 'package:e_commerce/presentation/state_holders/get_wish_list_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../state_holders/main_bottom_nav_controller.dart';
import '../widgets/product_card_wish_list.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {

      await Get.find<GetWishListDataController>().getWishListData();

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: () async {
        Get.find<MainBottomNavController>()
            .backToHomeScreen();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Wish List',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,

          leading: IconButton(
            onPressed: () {

              Get.find<MainBottomNavController>()
                  .backToHomeScreen();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.blueGrey,
            ),
          ),
        ),
        body: GetBuilder<GetWishListDataController>(
            builder: (getWishListDataController) {
          if (getWishListDataController.getProductInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (getWishListDataController.getWishListModel.data?.isEmpty ??
              true) {
            return const Center(
              child: Text("Wish list is empty"),
            );

          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
                itemCount:
                    getWishListDataController.getWishListModel.data?.length ??
                        0,

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return FittedBox(

                      child: ProductCardWishList(
                    wishListData:
                        getWishListDataController.getWishListModel.data![index],
                  ));
                }),
          );
        }),
      ),
    );
  }
}
