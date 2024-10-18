import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:s_medi/general/consts/consts.dart';

Widget buildReviewCard(QueryDocumentSnapshot review) {
  return Container(
    margin: const EdgeInsets.only(right: 5),
    width: 150,
    height: 120,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: AppColors.bgColor,
    ),
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Behavior: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: review['behavior'],
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        5.heightBox,
        RichText(
          maxLines: 2,
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Comment: ',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              TextSpan(
                text: review['comment'].toString().length > 30
                    ? '${review['comment'].toString().substring(0, 30)}...'
                    : review['comment'],
                style: const TextStyle(
                    color: Colors.black), // Comment text styling
              ),
            ],
          ),
        ),
        10.heightBox,
        RatingBarIndicator(
          rating: review['rating'].toDouble(),
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemCount: 5,
          itemSize: 20.0,
          direction: Axis.horizontal,
        ),
      ],
    ),
  );
}
