import 'package:e_commerce/presentation/state_holders/category_controller.dart';
import 'package:e_commerce/presentation/state_holders/new_product_controller.dart';
import 'package:e_commerce/presentation/ui/screens/auth/complete_profile_screen.dart';
import 'package:e_commerce/presentation/ui/screens/auth/email_verification_screen.dart';
import 'package:e_commerce/presentation/ui/screens/product_list_screen.dart';
import 'package:e_commerce/presentation/ui/screens/profile_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../theme/theme_service.dart';
import '../../state_holders/auth_controller.dart';
import '../../state_holders/home_slider_controller.dart';
import '../../state_holders/main_bottom_nav_controller.dart';
import '../../state_holders/popular_product_controller.dart';
import '../../state_holders/read_profile_controller.dart';
import '../../state_holders/special_product_controller.dart';
import '../utility/image_assets.dart';
import '../widgets/circular_icon_button.dart';
import '../widgets/home/category_card.dart';
import '../widgets/home/home_slider.dart';
import '../widgets/home/section_header.dart';
import '../widgets/product_card.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            SvgPicture.asset(
              ImageAssets.craftyBayNavLogoSVG,
            ),
            const Spacer(),

            CircularIconButton(

                icon: ThemeService().isSaveDarkMode() ? Icons.nightlight_round : Icons.wb_sunny, onTap: () {

              ThemeService().changeThemeMode();
              setState(() {

              });
            }),
            const SizedBox(
              width: 8,
            ),
            CircularIconButton(icon: Icons.person, onTap: () async{
              if(await AuthController.isLoggedIn){

                if(Get.find<ReadProfileController>().readProfileModel.data?.cusName?.isNotEmpty ?? false){

                  Get.to(()=>const ProfileInformationScreen());
                }else{

                  if(await Get.find<ReadProfileController>()
                      .isProfileCompleted()){
                    Get.to(()=>const ProfileInformationScreen());
                  }else{
                    Get.to(()=>const CompleteProfileScreen());
                  }
                }

              }else{
                Get.to(()=>const EmailVerificationScreen());
              }

            }),
            const SizedBox(
              width: 8,
            ),
            CircularIconButton(icon: Icons.call, onTap: () {}),
            const SizedBox(
              width: 8,
            ),
            CircularIconButton(icon: Icons.notifications_none, onTap: () {}),
            const SizedBox(
              width: 8,
            ),
            CircularIconButton(icon: Icons.logout, onTap: () {
              print("Logout");
              AuthController.clear();
              print("Is login : ${AuthController.isLoggedIn}");
              setState(() {

              });

            }),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade700,
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              GetBuilder<HomeSliderController>(builder: (homeSliderController) {
                if (homeSliderController.getHomeSliderInProgress) {
                  return const SizedBox(
                    height: 180,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return HomeSlider(
                  sliders: homeSliderController.sliderModel.data ?? [],
                );
              }),
              //category, this category will apply other places
              SectionHeader(
                title: 'Category',
                onTap: () {

                  Get.find<MainBottomNavController>().changeScreen(
                      1);
                },
              ),
              const SizedBox(
                height: 8,
              ),
              //category item
              SizedBox(
                height: 90,
                child: GetBuilder<CategoryController>(
                    builder: (categoryController) {
                  if (categoryController.getCategoryInProgress) {
                    return const SizedBox(
                      height: 180,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          categoryController.categoryModel.data?.length ?? 0,
                      itemBuilder: (context, index) {

                        return CategoryCard(
                          categoryData:
                              categoryController.categoryModel.data![index],
                          onTap: () {
                            Get.to(()=>
                              ProductListScreen(
                                categoryId: categoryController
                                    .categoryModel.data![index].id!,
                              ),
                            );
                          },
                        );
                      });
                }),
              ),
              const SizedBox(
                height: 16,
              ),
              SectionHeader(
                  title: 'Popular',
                  onTap: () {

                    Get.to(()=> GetBuilder<PopularProductController>(
                      builder: (ppController)  {
                        if(ppController.getPopularProductInProgress){
                          return Container(
                              color: Colors.white,
                              child: const Center(child: CircularProgressIndicator(),));
                        }
                        return ProductListScreen(productModel: Get.find<PopularProductController>().popularProductModel,);
                      }
                    ));
                  }),
              //Product item
              SizedBox(
                height: 165,
                child: GetBuilder<PopularProductController>(
                    builder: (productController) {
                  if (productController.getPopularProductInProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          productController.popularProductModel.data?.length ??
                              0,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: productController
                              .popularProductModel.data![index],
                        );
                      });
                }),
              ),

              //special
              const SizedBox(
                height: 16,
              ),
              SectionHeader(
                title: 'Special',
                onTap: () {

                  Get.to(()=>  GetBuilder<SpecialProductController>(
                    builder: (spController) {
                      if(spController.getSpecialProductInProgress){
                        return Container(
                            color: Colors.white,
                            child: const Center(child: CircularProgressIndicator(),));
                      }
                      return ProductListScreen(productModel: Get.find<SpecialProductController>().specialProductModel,);
                    }
                  ));
                },
              ),
              //Product item
              SizedBox(
                height: 165,
                child: GetBuilder<SpecialProductController>(
                    builder: (specialProductController) {
                  if (specialProductController.getSpecialProductInProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: specialProductController
                              .specialProductModel.data?.length ??
                          0,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: specialProductController
                              .specialProductModel.data![index],
                        );
                      });
                }),
              ),
              //New
              const SizedBox(
                height: 16,
              ),
              SectionHeader(
                title: 'New',
                onTap: () {

                  Get.to(()=>  GetBuilder<NewProductController>(
                    builder: (npController) {
                      if(npController.getNewProductInProgress){
                        return Container(
                            color: Colors.white,
                            child: const Center(child: CircularProgressIndicator(),));
                      }
                      return ProductListScreen(productModel: Get.find<NewProductController>().newProductModel,);
                    }
                  ));
                },
              ),
              //Product item
              SizedBox(
                height: 165,
                child: GetBuilder<NewProductController>(
                    builder: (newProductController) {
                  if (newProductController.getNewProductInProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          newProductController.newProductModel.data?.length ??
                              0,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product:
                              newProductController.newProductModel.data![index],
                        );
                      });
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
