import 'package:e_commerce/presentation/state_holders/cart_list_controller.dart';
import 'package:e_commerce/presentation/state_holders/create_invoice_controller.dart';
import 'package:e_commerce/presentation/state_holders/delete_cart_list_item_controller.dart';
import 'package:e_commerce/presentation/ui/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../state_holders/main_bottom_nav_controller.dart';
import '../utility/app_colors.dart';
import '../widgets/cart_product_card.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await Get.find<CartListController>().getCartList();
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
            'Carts',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.find<MainBottomNavController>().backToHomeScreen();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
            ),
          ),
        ),
        body: RefreshIndicator(
              // displacement: 120,
          onRefresh: () async{
            Get.find<CartListController>().getCartList();
          },
          child: GetBuilder<CartListController>(builder: (cartListController) {
            if (cartListController.getCartListInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(cartListController.cartListModel.data?.isEmpty?? true){
              return const Center(child: Text("No product in cart"));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartListController.cartListModel.data?.length ?? 0,

                    itemBuilder: (context, index) {
                      return GetBuilder<DeleteCartListItemController>(
                        builder: (deleteCartListItemController) {
                          return CartProductCard(
                            cartData: cartListController.cartListModel.data![index],
                            onTap: () {
                              print("delete button press at $index and productId is : ${cartListController.cartListModel.data![index].productId}");
                              deleteCartListItemController.deleteCartListItem(cartListController.cartListModel.data![index].productId!);
                            },
                          );
                        }
                      );
                    },
                  ),
                ),

                //bottom fixed content which contain Total price and checkout
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Price',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            '\$ ${cartListController.totalPrice}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          width: 120,
                          child: ElevatedButton(
                            onPressed: () {
                              if(Get.find<CartListController>().cartListModel.data?.isNotEmpty ?? false){
                                Get.to(()=>const CheckoutScreen());
                              }
                            },
                            child: const Text(
                              'Checkout',
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
