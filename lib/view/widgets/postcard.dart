import 'package:dummyjson/model/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title ?? 'No Title',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            if (post.body != null)
              Text(
                post.body!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: 8.0),
            if (post.tags != null && post.tags!.isNotEmpty)
              Wrap(
                spacing: 8.0,
                children:
                    post.tags!.map((tag) => Chip(label: Text(tag))).toList(),
              ),
            SizedBox(height: 5.w),
            if (post.reactions != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.thumb_up_alt_outlined),
                      Text(' ${post.reactions!.likes ?? 0}'),
                    ],
                  ),
                  SizedBox(width: 10.w),
                  Row(
                    children: [
                      const Icon(Icons.thumb_down_alt_outlined),
                      Text(' ${post.reactions!.dislikes ?? 0}'),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(Icons.remove_red_eye_outlined),
                      Text(' ${post.views}'),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
