import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s_medi/users/home/view/home.dart';

class ReviewController extends GetxController {
  final String docId;
  final String documentId;
  ReviewController(this.docId, this.documentId);

  var selectedBehavior = 'Good'.obs;
  var rating = 3.0.obs;
  TextEditingController commentController = TextEditingController();

  void updateBehavior(String behavior) {
    selectedBehavior.value = behavior;
  }

  void updateRating(double newRating) {
    rating.value = newRating;
  }

  Widget buildStar(int starIndex) {
    return Obx(() => IconButton(
          onPressed: () {
            updateRating(starIndex.toDouble());
          },
          icon: Icon(
            Icons.star,
            color: starIndex <= rating.value ? Colors.amber : Colors.grey,
            size: 32,
          ),
        ));
  }

  Future<void> submitReview() async {
    String behavior = selectedBehavior.value;
    String comment = commentController.text;
    double reviewRating = rating.value;

    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      Get.snackbar('Error', 'User not logged in',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    String reviewBy = currentUser.uid;

    try {
      // Submit the review
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(docId)
          .collection('reviews')
          .add({
        'behavior': behavior,
        'comment': comment,
        'rating': reviewRating,
        'reviewBy': reviewBy,
        'timestamp': FieldValue.serverTimestamp(),
      });

      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(documentId)
          .update({'review': true});

      QuerySnapshot reviewSnapshot = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(docId)
          .collection('reviews')
          .get();

      double totalRating = 0.0;
      int reviewCount = reviewSnapshot.docs.length;

      for (var doc in reviewSnapshot.docs) {
        totalRating += doc['rating'];
      }

      double averageRating = totalRating / reviewCount;

      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(docId)
          .update({'docRating': averageRating});

      Get.snackbar('Thank You', 'Thank you for giveing a review',
          snackPosition: SnackPosition.TOP);
      Get.offAll(() => const Home());
    } catch (e) {
      if (kDebugMode) {
        print('Error submitting review: $e');
      }
      Get.snackbar('Error', 'Failed to submit review',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
