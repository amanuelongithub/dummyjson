import 'package:dummyjson/controller/homepage_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ShowComments extends StatelessWidget {
  const ShowComments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Comments",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: GetBuilder<HomePageController>(builder: (_) {
        if (_.commentIsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (_.commentisError) {
          return Center(
              child: Text(_.commenterrorMessage ?? "Something went wrong"));
        } else {
          return SingleChildScrollView(
            child: Column(
              children:
                  List.generate(_.commentsModel!.comments!.length, (index) {
                final comments = _.commentsModel!.comments!;
                return ListTile(
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          comments[index].user!.username!,
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.favorite_outline_outlined,
                              size: 16.sp,
                            ),
                            Text(
                              comments[index].likes.toString(),
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(left: 8.0.sp, top: 5.sp),
                      child: Text(
                        comments[index].body!,
                      ),
                    ));
              }),
            ),
          );
        }
      }),
    );
  }
}
