import 'package:e_commerce/presentation/state_holders/product_review_get_controller.dart';
import 'package:e_commerce/presentation/state_holders/product_review_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../data/model/review_model.dart';
import '../../state_holders/auth_controller.dart';
import '../../state_holders/read_profile_controller.dart';
import '../utility/app_colors.dart';
import '../widgets/review_widget.dart';
import 'auth/complete_profile_screen.dart';
import 'auth/email_verification_screen.dart';
import 'create_review_screen.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {

      Get.find<ProductReviewGetController>().getProductReview(Get.find<ProductReviewPostController>().getProductId);
    });
    super.initState();
  }
  //List to store user multiple review
  final List<ReviewModel>userReviewList=[];

//add user review to the list
  void addReviewToList(String reviewDescription, String reviewRating){
    userReviewList.add(ReviewModel(reviewDescription: reviewDescription, reviewRating: reviewRating,));

    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reviews',
          style: TextStyle(color: Colors.black45),
        ),
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: const Icon(Icons.arrow_back_ios,color: Colors.black45,),),
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.primaryColor,
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

             const Expanded(


              child: ReviewsWidget(),//feed the list
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),

              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   GetBuilder<ProductReviewGetController>(
                     builder: (productReviewGetController) {
                       return Text('Reviews  (${productReviewGetController.productReviewModel.data?.length ?? 0})');
                     }
                   ),
                  SizedBox(
                    width: 40,
                    child: FloatingActionButton(
                      backgroundColor: AppColors.primaryColor,
                      onPressed: () async{
                        if(await AuthController.isLoggedIn){

                          if(Get.find<ReadProfileController>().readProfileModel.data?.cusName?.isNotEmpty ?? false){

                            Get.to(()=>CreateReviewScreen(getUserReview:addReviewToList));
                          }else{

                            if(await Get.find<ReadProfileController>()
                        .isProfileCompleted()){
                        Get.to(()=>CreateReviewScreen(getUserReview:addReviewToList));
                        }else{
                        Get.to(()=>const CompleteProfileScreen());
                        }
                        }

                        }else{
                        Get.to(()=>const EmailVerificationScreen());
                        }

                      },
                      child: const Icon(
                        Icons.add,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
