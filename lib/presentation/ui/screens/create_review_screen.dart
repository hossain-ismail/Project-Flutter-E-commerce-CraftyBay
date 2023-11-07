import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../state_holders/product_review_post_controller.dart';
import '../utility/app_colors.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key, required this.getUserReview});

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
  final Function(String reviewDescription,  String reviewRating) getUserReview;
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _reviewRatingTEC = TextEditingController();

  final TextEditingController _reviewDescriptionTEC = TextEditingController();


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
                //first name
                TextFormField(
                  controller: _reviewRatingTEC,
                  decoration: const InputDecoration(
                    hintText: 'rating between 0 to 5 ',
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Give rating';
                    }
                    return null;
                  },
                ),
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

                            double reviewRating = double.tryParse(_reviewRatingTEC.text)!;
                            if(reviewRating>5){
                              reviewRating=5;
                            }
                            if(reviewRating.floor()<reviewRating){
                              reviewRating =reviewRating.floor()+ 0.5;
                            }

                            widget.getUserReview(reviewRating.toString(),_reviewDescriptionTEC.text);
                            productReviewPostController.postProductReview(_reviewDescriptionTEC.text,reviewRating.toString()).then((success){
                              if(success){
                                //clear the controller
                                _reviewRatingTEC.clear();

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
  print("value of controller is : ${_reviewRatingTEC.text}");
  //clear the controller
  _reviewRatingTEC.clear();
  _reviewDescriptionTEC.clear();
  print("value of controller is : ${_reviewRatingTEC.text}");
    super.dispose();
  }

}
