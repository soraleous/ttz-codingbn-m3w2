import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

// Star Selection for ratings/reviews

class StarRating extends StatelessWidget {
  StarRating({
    this.rating,
    this.color = Colors.amber,
    this.size = 24,
  });

  final double rating;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SmoothStarRating(
      starCount: 5,
      allowHalfRating: true,
      rating: rating,
      color: color,
      borderColor: color,
      size: size,
      isReadOnly: true,
    );
  }
}
