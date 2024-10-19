import 'package:s_medi/general/consts/consts.dart';

import '../controller/review_controller.dart';

class ReviewPage extends StatelessWidget {
  final String docId;
  final String documetId;
  const ReviewPage({super.key, required this.docId, required this.documetId});

  @override
  Widget build(BuildContext context) {
    final ReviewController reviewController =
        Get.put(ReviewController(docId, documetId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Give a Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Behavior Selection
              const Text(
                'How was the behavior?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Column(
                children: <Widget>[
                  Obx(() => ListTile(
                        title: const Text('Good'),
                        leading: Radio(
                          value: 'Good',
                          groupValue: reviewController.selectedBehavior.value,
                          onChanged: (value) {
                            reviewController.updateBehavior(value!);
                          },
                        ),
                      )),
                  Obx(() => ListTile(
                        title: const Text('Average'),
                        leading: Radio(
                          value: 'Average',
                          groupValue: reviewController.selectedBehavior.value,
                          onChanged: (value) {
                            reviewController.updateBehavior(value!);
                          },
                        ),
                      )),
                  Obx(() => ListTile(
                        title: const Text('Bad'),
                        leading: Radio(
                          value: 'Bad',
                          groupValue: reviewController.selectedBehavior.value,
                          onChanged: (value) {
                            reviewController.updateBehavior(value!);
                          },
                        ),
                      )),
                ],
              ),
              const SizedBox(height: 20),
              // Comment Section
              const Text(
                'Additional Comments (Optional)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: reviewController.commentController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Enter your comments here...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Rating Section with Stars
              const Text(
                'Give a Rating',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: List.generate(
                    5, (index) => reviewController.buildStar(index + 1)),
              ),
              const SizedBox(height: 20),
              // Submit Button
              Center(
                child: SizedBox(
                  width: context.screenWidth * .5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primeryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      reviewController.submitReview();
                    },
                    child: Obx(
                      () => reviewController.loading.value
                          ? Center(
                              child: CircularProgressIndicator(
                                color: AppColors.whiteColor,
                              ),
                            )
                          : Text(
                              'Submit Review',
                              style: TextStyle(color: AppColors.whiteColor),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
