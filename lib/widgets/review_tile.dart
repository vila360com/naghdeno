import 'package:flutter/material.dart';
import '../models/book_models.dart';
import 'rating_stars.dart';

class ReviewTile extends StatelessWidget {
  final Review review;

  const ReviewTile({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(review.userAvatar),
                  radius: 18,
                  backgroundColor: Colors.grey.shade300,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.userName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      RatingStars(rating: review.rating, size: 14),
                    ],
                  ),
                ),
                Text(
                  '${review.date.year}/${review.date.month}/${review.date.day}',
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              review.content,
              style: const TextStyle(height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
