import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:s_medi/users/all%20reviews/widget/review_grid_item.dart';

class AllReviewsPage extends StatelessWidget {
  final String doctorId;

  const AllReviewsPage({Key? key, required this.doctorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Reviews'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('doctors')
            .doc(doctorId)
            .collection('reviews')
            .orderBy('rating', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No reviews available"));
          }

          var reviews = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                var review = reviews[index];
                return ReviewGridItem(review: review);
              },
            ),
          );
        },
      ),
    );
  }
}
