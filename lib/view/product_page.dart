import 'dart:developer';

import 'package:dummyjson/controller/homepage_controller.dart';
import 'package:dummyjson/view/widgets/product_card.dart';
import 'package:dummyjson/view/widgets/showreviews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListner);
    Get.put(HomePageController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomePageController>(builder: (_) {
        if (_.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (_.isError) {
          return Center(child: Text(_.errorMessage ?? "Something went wrong"));
        } else {
          return SingleChildScrollView(
              controller: _scrollController,
              clipBehavior: Clip.none,
              scrollDirection: Axis.vertical,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                      children: List.generate(_.productsModel!.products!.length,
                          (index) {
                    return GestureDetector(
                      onTap: () {
                        if (_.productsModel!.products![index].reviews != null &&
                            _.productsModel!.products![index].reviews!
                                .isNotEmpty) {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: 400.h,
                                child: ShowReviews(
                                  review: _
                                      .productsModel!.products![index].reviews!,
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: ProductCard(
                          product: _.productsModel!.products![index]),
                    );
                  }))));
        }
      }),
    );
  }

  void _scrollListner() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !Get.find<HomePageController>().productsPaginatedLoading) {
      log('usucbdjbvjbdv0');
      Get.find<HomePageController>().fetchPaginatedProductes();
    }
  }
}
