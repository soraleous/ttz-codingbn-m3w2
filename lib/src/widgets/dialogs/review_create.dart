import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../../model/review.dart';

// Review Creation Dialog

class ReviewCreateDialog extends StatefulWidget {
  final String userName;
  final String userId;

  ReviewCreateDialog({this.userName, this.userId, Key key});

  @override
  _ReviewCreateDialogState createState() => _ReviewCreateDialogState();
}

class _ReviewCreateDialogState extends State<ReviewCreateDialog> {
  double rating = 0;
  String review;

  // Star count selection is rather buggy on web as it works on mobile platforms
  @override
  Widget build(BuildContext context) {
    Color color = rating == 0 ? Colors.amber : Colors.grey;
    return AlertDialog(
      title: Text('Add a Review'),
      content: Container(
        width: math.min(MediaQuery.of(context).size.width, 740),
        height: math.min(MediaQuery.of(context).size.height, 180),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: SmoothStarRating(
                starCount: 5,
                rating: rating,
                color: color,
                borderColor: Colors.amber,
                size: 32,
                onRated: (value) {
                  if (mounted) {
                    rating = value;
                  }
                },
              ),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration.collapsed(
                    hintText: 'Type your review here.'),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (value) {
                  if (mounted) {
                    setState(() {
                      review = value;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('CANCEL'),
          onPressed: () => Navigator.pop(context, null),
        ),
        ElevatedButton(
          child: Text('SAVE'),
          onPressed: () => Navigator.pop(
            context,
            Review.fromUserInput(
              rating: rating,
              text: review,
              userId: widget.userId,
              userName: widget.userName,
            ),
          ),
        ),
      ],
    );
  }
}
