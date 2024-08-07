import 'package:dummyjson/controller/homepage_controller.dart';
import 'package:dummyjson/view/widgets/postcard.dart';
import 'package:dummyjson/view/widgets/show_comments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
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
              clipBehavior: Clip.none,
              scrollDirection: Axis.vertical,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                      children: List.generate(_.productsModel!.products!.length,
                          (index) {
                    return GestureDetector(
                      onTap: () async {
                        _.fetchComments(_.postsModel!.posts![index].id!);
                        showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 400.h,
                              child: const ShowComments(),
                            );
                          },
                        );
                      },
                      child: PostCard(post: _.postsModel!.posts![index]),
                    );
                  }))));
        }
      }),
    );
  }
}
