import 'dart:developer';
import 'package:e_commerce/data/model/product_model.dart';
import 'package:e_commerce/presentation/state_holders/product_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  final int ? categoryId;
  final ProductModel ? productModel;

  const ProductListScreen({super.key,  this.categoryId, this.productModel});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {

      if(widget.categoryId != null){
        Get.find<ProductListController>()
            .getProductsByCategory(widget.categoryId!);
      }else if(widget.productModel !=null){
          Get.find<ProductListController>().setProduct(widget.productModel!);
      }

    });
    super.initState();
  }

//just copy wishlist screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Product list',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,

        leading: const BackButton(
          color: Colors.black,
        ),

      ),
      body: GetBuilder<ProductListController>(builder: (productListController) {
        if (productListController.getProductInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (productListController.productModel.data?.isEmpty ?? true) {


          return const Center(
            child: Text('Empty list'),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {

                return FittedBox(

                  child: ProductCard(
                    product: productListController.productModel.data![index],
                  ),
                );
              },
          itemCount:productListController.productModel.data?.length ?? 0 ,
          ),
        );
      }),
    );
  }
}
