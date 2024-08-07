import 'package:dummyjson/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ShowReviews extends StatelessWidget {
  final List<Review> review;
  const ShowReviews({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Review",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(review.length, (index) {
            return ListTile(
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      review[index].reviewerName!,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      getDateMonth(review[index].date!).toString(),
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(left: 8.0.sp, top: 5.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review[index].comment!,
                      ),
                      RatingBar.builder(
                        initialRating: review[index].rating!.toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 15.0,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                    ],
                  ),
                ));
          }),
        ),
      ),
    );
  }

  getDateMonth(DateTime date) {
    return DateFormat('dd, MMM').format(date);
  }
}
