import 'package:e_commerce/data/model/product_details.dart';
import 'package:e_commerce/presentation/state_holders/add_to_cart_controller.dart';
import 'package:e_commerce/presentation/state_holders/create_wish_list_controller.dart';
import 'package:e_commerce/presentation/state_holders/product_details_controller.dart';
import 'package:e_commerce/presentation/state_holders/product_review_post_controller.dart';
import 'package:e_commerce/presentation/ui/screens/reviews_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../state_holders/auth_controller.dart';
import '../utility/app_colors.dart';
import '../widgets/custom_stepper.dart';
import '../widgets/home/product_image_slider.dart';
import '../widgets/product_details_screen/color_picker.dart';
import '../widgets/product_details_screen/pick_color_and_size.dart';
import 'auth/complete_profile_screen.dart';
import 'auth/email_verification_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 0;
  int quantity=1;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProductDetailsController>().getProductDetails(widget.productId);

      AuthController.getIsProfileComplete();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GetBuilder<ProductDetailsController>(
          builder: (productDetailsController) {
        if (productDetailsController.getProductDetailsInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ProductImageSlider(
                            imageList: [

                              productDetailsController.productDetails.img1 ??
                                  '',
                              productDetailsController.productDetails.img2 ??
                                  '',
                              productDetailsController.productDetails.img3 ??
                                  '',
                              productDetailsController.productDetails.img4 ??
                                  '',
                            ],
                          ),
                          productDetailsAppBar,
                        ],
                      ),
                      //full body of page from below the slider
                      productDetails(
                        productDetailsController.productDetails,
                        productDetailsController.availableColor,
                      ), // access ProductDetails object by controller
                    ],
                  ),
                ),
              ),
              //price to add card
              cartToCartBottomContainer(
                productDetailsController.productDetails,
                productDetailsController.availableColor,
                productDetailsController.availableSizes,
              )
            ],
          ),
        );
      }),
    );
  }

  //product details contain all the information of this page
  Padding productDetails(
      ProductDetails productDetails, List<String> colorFromApi) {

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Text(
                  productDetails.product?.title ?? '',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5),
                ),
              ),
              CustomStepper(
                lowerLimit: 1,
                upperLimit: 10,
                stepValue: 1,
                value: 1,
                onChange: (newValue) {
                  quantity=newValue;
                  print(newValue);
                },
              ),
            ],
          ),
          //rating and review
          Row(
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Icon(
                    Icons.star,
                    size: 18,
                    color: Colors.amber,
                  ),
                  //make sure product star rating not more than 5
                  Text(
                    "(${(productDetails.product?.star ?? 0) > 5 ? 5 : productDetails.product?.star})",
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => const ReviewsScreen());
                },
                child: const Text(
                  'Review',
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Card(
                color: AppColors.primaryColor,
                child: GestureDetector(
                  onTap: () {
                    //get productId form ProductReviewPostController
                    Get.find<CreateWishListController>().getCreateWishList(
                        Get.find<ProductReviewPostController>().getProductId);
                  },
                  child: GetBuilder<CreateWishListController>(
                      builder: (createWishListController) {
                    if (createWishListController.getCreateWishListInProgress) {
                      return Container(
                        width: 20,
                        height: 20,
                        color: Colors.white,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return const Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.favorite_border,
                        size: 16,
                        color: Colors.white,
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
          //color
          const Text(
            'Color',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          //get color using PickColorAndSize
          SizedBox(
            height: 28,
            child: PickColorAndSize(
              sizes: productDetails.color?.split(',') ?? [],
              selectedIndex: _selectedColorIndex,
              onSizeSelected: (index ) {
                //this parameter index got value by user click from PickColorAndSize
              _selectedColorIndex=index;
              print("reverse data get color index from PickColorAndSize :$index");
                if(mounted){
                  setState(() {

                  });
                }
            },
            ),

          ),


          const SizedBox(
            height: 16,
          ),
          //Size picker
          const Text(
            'Size',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          //Size picker
          SizedBox(
            height: 28,
            child: PickColorAndSize(
              sizes: productDetails.size?.split(',') ?? [],
              selectedIndex: _selectedSizeIndex,
               onSizeSelected: (index ) {
                //this parameter index got value by user click from PickColorAndSize
                 print("reverse data get size index from PickColorAndSize :$index");
              _selectedSizeIndex=index;
              if(mounted){
                setState(() {

                });
              }
            },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          //description
          const Text(
            "Description",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(productDetails.des ?? ''),
        ],
      ),
    );
  }

  //appbar
  AppBar get productDetailsAppBar {
    return AppBar(
      leading: const BackButton(
        color: Colors.black54,
      ),

      title: const Text(
        'Product Details',
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0, //unless appbar will not be fully transparent
    );
  }


  Container cartToCartBottomContainer(
      ProductDetails details, List<String> colors, List<String> sizes) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Price',
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
                '\$ ${details.product?.price?? ''}'
                /*'\$1,000'*/,
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
              child: GetBuilder<AddToCartController>(
                  builder: (addToCartController) {
                return ElevatedButton(
                  onPressed: () async {
                    final isLogin = await AuthController.isLoggedIn;
                    final isProfileComplete = await AuthController.isProfileCompleted!;
                    if(!isLogin) {
                      print("Login information $isLogin");
                      Get.offAll(() => const EmailVerificationScreen());
                    }else if(!isProfileComplete){
                      print("inside product details - sharedPreference: $isProfileComplete");
                      Get.offAll(()=>const CompleteProfileScreen());
                    }else{
                      final result = await addToCartController.addToCart(
                        details.productId!,
                        colors[_selectedColorIndex].toString(),
                        sizes[_selectedSizeIndex],
                        quantity,

                      );
                      if (result) {
                        Get.snackbar('Added to cart',
                            'This product has been added to cart list',
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    }

                    print("Color index :$_selectedColorIndex}");


                    print("Size index :$_selectedColorIndex}");

                  },
                  child: const Text(
                    'Add to Cart',
                  ),
                );
              })),
        ],
      ),
    );
  }
}
