import 'package:e_commerce/data/model/cart_list_model.dart';
import 'package:e_commerce/presentation/state_holders/cart_list_controller.dart';
import 'package:e_commerce/presentation/ui/screens/product_details_screen.dart';
import 'package:e_commerce/presentation/ui/utility/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utility/app_colors.dart';
import 'custom_stepper.dart';

class CartProductCard extends StatelessWidget {
  final CartData cartData;
   final VoidCallback onTap;

   CartProductCard({
    super.key,
    required this.cartData, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(()=>ProductDetailsScreen(productId: cartData.product!.id!));
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            //shoe image
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),

              ),
              child: Image.network(
                cartData.product?.image ?? '',
                errorBuilder: (context, _, __) {
                  return Image.asset(
                    ImageAssets.shoePng,
                  );
                },
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            //title and subtitle
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartData.product?.title ??
                                    "Product name is not available",
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                  children: [

                                    TextSpan(
                                        text: 'Color:${cartData.color ?? ''},'),
                                    TextSpan(text: 'Size: ${cartData.size}'),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                          IconButton(
                            style: IconButton.styleFrom(),
                            onPressed: () {
                              Get.find<CartListController>().removeFromCart(cartData.productId!);
                            },
                            icon: const Icon(Icons.delete_outline)),

                      ],
                    ),
                    //second line price and stepper button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          //individual price
                          "\$${cartData.product?.price ?? ' '}",
                          style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: 85,
                          child: FittedBox(
                            child: CustomStepper(
                              lowerLimit: 1,
                              upperLimit: 20,
                              stepValue: 1,

                              value: cartData.quantity!,

                              onChange: (int value) {
                                Get.find<CartListController>()
                                    .changeItem(cartData.id!, value);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
