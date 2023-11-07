import 'package:e_commerce/presentation/state_holders/category_controller.dart';
import 'package:e_commerce/presentation/ui/screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../state_holders/main_bottom_nav_controller.dart';
import '../widgets/home/category_card.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: () async {
        Get.find<MainBottomNavController>()
            .backToHomeScreen();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Category',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,

          leading: IconButton(
            onPressed: () {

              Get.find<MainBottomNavController>()
                  .backToHomeScreen();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.blueGrey,
            ),
          ),
        ),
        body: RefreshIndicator(

          onRefresh: () async{

            Get.find<CategoryController>().getCategories();

          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),

            child: GetBuilder<CategoryController>(builder: (categoryController) {

              if (categoryController.getCategoryInProgress) {
                return const SizedBox(
                  height: 180,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return GridView.builder(
                  itemCount: categoryController.categoryModel.data?.length ?? 0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    return FittedBox(

                      child: CategoryCard(
                        categoryData:
                            categoryController.categoryModel.data![index],
                        onTap: () {
                          Get.to(ProductListScreen(categoryId: categoryController.categoryModel.data![index].id!));
                        },
                      ),
                    );
                  });
            }),
          ),
        ),
      ),
    );
  }
}
