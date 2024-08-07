import 'package:dummyjson/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // Import for rating bar

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      
      elevation: 4, // Add elevation for a slight shadow effect
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)), // Rounded corners
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Consistent padding
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align content to the left
          children: [
            // Image (if available)
            if (product.thumbnail != null)
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(10), // Rounded corners for image
                child: Image.network(
                  product.thumbnail!,
                  height: 150,
                  width: double.infinity, // Fit image to full width
                  fit: BoxFit.cover, // Ensure image fills the container
                  errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Icon(Icons.error)), // Error handling
                ),
              ),

            // Title (with spacing)
            const SizedBox(height: 8),
            Text(
              product.title!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            if (product.rating != null)
              Row(
                children: [
                  const Text('Rating: '),
                  RatingBar.builder(
                    initialRating: product.rating!.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20.0,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                ],
              ),

            const SizedBox(height: 8),
            Text(
              '${product.price.toString()} \$',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
