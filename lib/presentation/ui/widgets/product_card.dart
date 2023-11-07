import 'package:e_commerce/data/model/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../state_holders/product_review_post_controller.dart';
import '../screens/product_details_screen.dart';
import '../utility/app_colors.dart';
import '../utility/image_assets.dart';
class ProductCard extends StatelessWidget {
 final Product product;

  const ProductCard({
    super.key, required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(

      borderRadius: BorderRadius.circular(8),
      onTap: (){
        print("Product Id is ${product.id!}");

        Get.find<ProductReviewPostController>().setProductId(product.id!);
        Get.to(()=> ProductDetailsScreen(productId: product.id!,));
      },
      child: Card(
        shadowColor: AppColors.primaryColor.withOpacity(0.1),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          width: 130,
          child: Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(8),topRight:  Radius.circular(8),),
                  color: AppColors.primaryColor.withOpacity(0.1),
                  image:  DecorationImage(
                    // image: AssetImage(ImageAssets.shoePng),
                    image: NetworkImage(product.image ?? ''),
                  ),
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      product.title ?? '',
                      maxLines: 1,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey),
                    ),
                    const SizedBox(height: 2,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // '\$90',
                    '\$${product.price ?? 0}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,

                          ),
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 15,
                              color: Colors.amber,

                            ),
                            //make sure product star rating not more than 5, this will apply all the product category like category popular,new,special product
                            Text(
                              "(${(product.star ?? 0)>5 ? 5 : product.star })",
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                        const Card(
                          color: AppColors.primaryColor,
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.favorite_border,
                              size: 12,
                              color: Colors.white,

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
