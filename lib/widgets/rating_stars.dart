import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double size;
  final Color color;

  const RatingStars({
    super.key,
    required this.rating,
    this.size = 18.0,
    this.color = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      if (rating >= i) {
        stars.add(Icon(Icons.star, size: size, color: color));
      } else if (rating >= i - 0.5) {
        stars.add(Icon(Icons.star_half, size: size, color: color));
      } else {
        stars.add(Icon(Icons.star_border, size: size, color: color));
      }
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }
}
