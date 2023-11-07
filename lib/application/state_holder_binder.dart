import 'package:e_commerce/presentation/state_holders/add_to_cart_controller.dart';
import 'package:e_commerce/presentation/state_holders/category_controller.dart';
import 'package:e_commerce/presentation/state_holders/create_invoice_controller.dart';
import 'package:e_commerce/presentation/state_holders/new_product_controller.dart';
import 'package:e_commerce/presentation/state_holders/product_details_controller.dart';
import 'package:e_commerce/presentation/state_holders/product_list_controller.dart';
import 'package:e_commerce/presentation/state_holders/read_profile_controller.dart';
import 'package:e_commerce/presentation/state_holders/special_product_controller.dart';
import 'package:get/get.dart';
import '../presentation/state_holders/cart_list_controller.dart';
import '../presentation/state_holders/create_profile_controller.dart';
import '../presentation/state_holders/create_wish_list_controller.dart';
import '../presentation/state_holders/delete_cart_list_item_controller.dart';
import '../presentation/state_holders/delete_wish_list_controller.dart';
import '../presentation/state_holders/email_verification_controller.dart';
import '../presentation/state_holders/get_wish_list_data_controller.dart';
import '../presentation/state_holders/home_slider_controller.dart';
import '../presentation/state_holders/invoice_list_controller.dart';
import '../presentation/state_holders/main_bottom_nav_controller.dart';
import '../presentation/state_holders/otp_verification_controller.dart';
import '../presentation/state_holders/popular_product_controller.dart';
import '../presentation/state_holders/product_review_get_controller.dart';
import '../presentation/state_holders/product_review_post_controller.dart';

class StateHolderBinder extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(MainBottomNavController());
    Get.put(EmailVerificationController());
    Get.put(OtpVerificationController());
    Get.put(HomeSliderController());
    Get.put(CategoryController());
    Get.put(PopularProductController());
    Get.put(NewProductController());
    Get.put(SpecialProductController());
    Get.put(ProductDetailsController());
    Get.put(AddToCartController());
    Get.put(ProductListController());
    Get.put(CartListController());
    Get.put(DeleteCartListItemController());
    Get.put(ProductReviewPostController());
    Get.put(ProductReviewGetController());
    Get.put(CreateWishListController());
    Get.put(GetWishListDataController());
    Get.put(CreateProfileController());
    Get.put(ReadProfileController());
    Get.put(CreateInvoiceController());
    Get.put(InvoiceListController());
    Get.put(DeleteWishListController());
  }

}