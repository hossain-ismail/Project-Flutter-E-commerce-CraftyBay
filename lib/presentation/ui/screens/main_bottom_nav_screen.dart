import 'package:e_commerce/presentation/state_holders/category_controller.dart';
import 'package:e_commerce/presentation/state_holders/new_product_controller.dart';
import 'package:e_commerce/presentation/state_holders/special_product_controller.dart';
import 'package:e_commerce/presentation/ui/screens/wish_lis_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../state_holders/home_slider_controller.dart';
import '../../state_holders/main_bottom_nav_controller.dart';
import '../../state_holders/popular_product_controller.dart';
import '../utility/app_colors.dart';
import 'cart_screen.dart';
import 'category_list_screen.dart';
import 'home_screen.dart';
class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<HomeSliderController>().getHomeSlider();
      Get.find<CategoryController>().getCategories();
      Get.find<PopularProductController>().getPopularProduct();
      Get.find<SpecialProductController>().getSpecialProduct();
      Get.find<NewProductController>().getNewProduct();
    });
    super.initState();
  }

  final List<Widget> _screen= [
    const HomeScreen(),
    const CategoryListScreen(),
    const CardScreen(),
    const WishListScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavController>(
      builder: (controller) {
        return Scaffold(
          body: _screen[controller.currentSelectedIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.currentSelectedIndex,

              onTap: controller.changeScreen,
              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              elevation: 4,

              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled,), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard,), label: 'Categories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart,), label: 'Cart'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border,), label: 'Wishlist'),

              ]),
        );

      }
    );
  }
}
