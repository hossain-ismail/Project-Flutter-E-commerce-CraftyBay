import 'package:flutter/material.dart';
class StarRating extends StatelessWidget {
   double rating;
  final int starCount;
  final double size;

  StarRating({required this.rating, this.starCount = 5, this.size = 24.0});

  @override
  Widget build(BuildContext context) {

    if(rating>5){
      rating=5;
    }

    int fullStars = rating.floor();
    bool hasHalfStar = rating - fullStars > 0;
    bool hasEmptyStars = starCount - fullStars - (hasHalfStar ? 1 : 0) > 0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(fullStars, (index) {
        return Icon(
          Icons.star,
          color: Colors.amber,
          size: size,
        );
      }) +
          (hasHalfStar
              ? [
            Icon(
              Icons.star_half,
              color: Colors.amber,
              size: size,
            )
          ]
              : []) +
          (hasEmptyStars
              ? List.generate(
            starCount - fullStars - (hasHalfStar ? 1 : 0),
                (index) {
              return Icon(
                Icons.star_border,
                color: Colors.amber,
                size: size,
              );
            },
          )
              : []),
    );
  }
}