import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/model/wish_list_model.dart';
import '../../state_holders/delete_wish_list_controller.dart';
import '../../state_holders/get_wish_list_data_controller.dart';
import '../../state_holders/product_review_post_controller.dart';
import '../screens/product_details_screen.dart';
import '../utility/app_colors.dart';
class ProductCardWishList extends StatelessWidget {
 final WishListData wishListData;

  const ProductCardWishList({super.key, required this.wishListData,  });



  @override
  Widget build(BuildContext context) {
    return InkWell(

      borderRadius: BorderRadius.circular(8),
      onTap: (){
        print("Product Id is ${wishListData.id!}");

        Get.find<ProductReviewPostController>().setProductId(wishListData.id!);
        Get.to(()=> ProductDetailsScreen(productId: wishListData.productId!,));
      },
      child: Card(
        shadowColor: AppColors.primaryColor.withOpacity(0.1),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          width: 150,
          child: Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(8),topRight:  Radius.circular(8),),
                  color: AppColors.primaryColor.withOpacity(0.1),
                  image:  DecorationImage(
                    image: NetworkImage(wishListData.product?.image ?? ''),
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      wishListData.product?.title ?? '',
                      maxLines: 1,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey),
                    ),
                    const SizedBox(height: 2,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // '\$90',
                    '\$${wishListData.product?.price ?? 0}',
                          style: const TextStyle(
                            fontSize: 15,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,

                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 20,
                              color: Colors.amber,

                            ),
                            Text(
                              "${wishListData.product?.star ?? 0}",
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                         Card(
                          color: AppColors.primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: GestureDetector(
                              onTap: (){
                           showDialog(context: context, builder: (context){
                             return AlertDialog(
                               title: Text("Are you sure?"),
                               content: Row(
                                 children: [
                                   TextButton(onPressed: () async{
                                     Get.back();
                                      Get.find<DeleteWishListController>().getRemoveWishListProduct(wishListData.productId!);
                                     await Get.find<GetWishListDataController>().getWishListData();


                                   }, child: Text("Delete")),
                                   TextButton(onPressed: (){Get.back();}, child: Text('Cancel'))
                                 ],
                               ),
                             );
                           });
                                print("Delete Button Press");
                              },
                              child: const Icon(
                                Icons.delete_forever_rounded,
                                size: 20,
                                color: Colors.white,

                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
