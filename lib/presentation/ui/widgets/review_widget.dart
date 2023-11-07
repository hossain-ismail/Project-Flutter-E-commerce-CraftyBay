import 'package:e_commerce/presentation/state_holders/product_review_get_controller.dart';
import 'package:e_commerce/presentation/state_holders/product_review_post_controller.dart';
import 'package:e_commerce/presentation/ui/widgets/star_rating.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/review_model.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({
    super.key,

  });

  //if user by mistake set String as rating value then make it 0
  double parseRating(dynamic ratingValue) {
    if (ratingValue is String) {
      try {
        return double.parse(ratingValue);
      } catch (e) {
        return 0.0; // Parsing error, set it to 0.0
      }
    } else if (ratingValue is double) {
      return ratingValue;
    } else {
      return 0.0; // Handle other data types as well
    }
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
    displacement: 206,
      onRefresh: () async{
      await  Get.find<ProductReviewGetController>().getProductReview(Get.find<ProductReviewPostController>().getProductId);
      },
      child: GetBuilder<ProductReviewGetController>(

          builder: (productReviewGetController) {
        if (productReviewGetController.productReviewInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (productReviewGetController.productReviewModel.data?.isEmpty ?? true) {
          return const Center(
            child: Text("No review on this product"),
          );
        }
        return ListView.separated(
          itemCount:
              productReviewGetController.productReviewModel.data?.length ?? 0,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 243, 243, 243),
                          radius: 16,
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),

                        Text(
                          "${productReviewGetController.productReviewModel.data![index].profile!.cusName}",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.black54,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(children: [

                      StarRating(
                        rating: parseRating(productReviewGetController.productReviewModel.data![index].rating),
                        size: 15.0,
                      ),
                      SizedBox(width: 4,),
                      Text("(${ parseRating(productReviewGetController.productReviewModel.data![index].rating) >5 ? 5 :parseRating(productReviewGetController.productReviewModel.data![index].rating)})"), // (rating)
                    ],),
                    const SizedBox(
                      height: 8,
                    ),
                    //review text
                    Text(
                      productReviewGetController
                              .productReviewModel.data![index].description ??
                          '',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, index) {
            return const SizedBox(
              height: 5,
            );
          },
        );
      }),
    );
  }
}
