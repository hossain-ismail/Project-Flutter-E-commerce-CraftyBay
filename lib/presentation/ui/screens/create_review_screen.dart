import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../data/model/review_model.dart';
import '../../state_holders/product_review_post_controller.dart';
import '../utility/app_colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key, required this.getUserReview});

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
  final Function(String reviewDescription,  String reviewRating) getUserReview;
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _reviewDescriptionTEC = TextEditingController();

  double userRatings = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Review',
          style: TextStyle(color: Colors.black45),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black45,
            )),
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.primaryColor,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),

                //rating
                const Text('Please give your feedback',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                SizedBox(height: 5,),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    userRatings=rating;
                    print(rating);
                    setState(() {

                    });
                  },
                ),
                Text('Rating : $userRatings',),

                const SizedBox(
                  height: 15,
                ),
                //review
                TextFormField(
                  controller: _reviewDescriptionTEC,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    hintText: ' Write Review',
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your Review';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                //submit button
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<ProductReviewPostController>(
                      builder: (productReviewPostController) {
                        if(productReviewPostController.productReviewInProgress){
                          return Center(child: CircularProgressIndicator(),);
                        }
                        return ElevatedButton(
                            onPressed: () {
                              if(!_formKey.currentState!.validate()){
                                return;
                              }
                              print("your review is : $userRatings");

                              widget.getUserReview(userRatings.toString(),_reviewDescriptionTEC.text);
                              productReviewPostController.postProductReview(_reviewDescriptionTEC.text,userRatings.toString()).then((success){
                                if(success){
                                  //clear the controller
                                  _reviewDescriptionTEC.clear();
                                }
                              });

                              setState(() {

                              });

                            }, child: const Text('Submit'));
                      }
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  //if user review attempt fail and back then we need to clear the controller
  @override
  void dispose() {
    //clear the controller
    _reviewDescriptionTEC.clear();

    super.dispose();
  }

}
