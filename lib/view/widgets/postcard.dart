import 'package:dummyjson/model/posts_model.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
          children: [
            // Title
            Text(
              post.title ?? 'No Title',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0), // Add some vertical spacing

            // Body (optional)
            if (post.body != null)
              Text(
                post.body!,
                maxLines: 3, // Limit body text lines to avoid overflow
                overflow: TextOverflow.ellipsis, // Add ellipsis for long text
              ),
            const SizedBox(height: 8.0), // Add spacing after body

            // Tags (optional)
            if (post.tags != null && post.tags!.isNotEmpty)
              Wrap(
                spacing: 8.0, // Spacing between tags
                children: post.tags!.map((tag) => Chip(label: Text(tag))).toList(),
              ),

            // Reactions (optional)
            if (post.reactions != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align icons
                children: [
                  Row(
                    children: [
                      const Icon(Icons.thumb_up_alt_outlined),
                      Text(' ${post.reactions!.likes ?? 0}'),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.thumb_down_alt_outlined),
                      Text(' ${post.reactions!.dislikes ?? 0}'),
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
