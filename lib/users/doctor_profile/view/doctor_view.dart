import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:s_medi/general/consts/consts.dart';
import 'package:s_medi/users/all%20reviews/all_reviews.dart';
import 'package:s_medi/users/doctor_profile/widgets/review_card.dart';

import '../../book_appointment/view/appointment_view.dart';
import '../../widgets/coustom_button.dart';

class DoctorProfile extends StatelessWidget {
  final DocumentSnapshot doc;
  const DoctorProfile({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: "Doctor details".text.make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.bgDarkColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 75,
                      width: 75,
                      child: doc['image'] == ''
                          ? Image.asset(
                              AppAssets.imgLogin,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              doc['image'],
                            ),
                    ),
                    15.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(doc['docName']),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.verified,
                                color: Colors.green,
                                size: 15,
                              )
                            ],
                          ),
                          Text("Category : ${doc['docCategory']}"),
                          8.heightBox,
                          RatingBarIndicator(
                            rating: double.parse(doc['docRating'].toString()),
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => AllReviewsPage(
                            doctorId: doc.id,
                          ),
                        );
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primeryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Center(
                            child: Text(
                              "See All reviews",
                              style: TextStyle(color: AppColors.whiteColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              10.heightBox,
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.bgDarkColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "About".text.semiBold.size(AppFontSize.size18).make(),
                    5.heightBox,
                    doc['docAbout']
                        .toString()
                        .text
                        .size(AppFontSize.size14)
                        .make(),
                    10.heightBox,
                    "Address".text.semiBold.size(AppFontSize.size18).make(),
                    5.heightBox,
                    doc['docAddress']
                        .toString()
                        .text
                        .size(AppFontSize.size14)
                        .make(),
                    10.heightBox,
                    "Working Time"
                        .text
                        .semiBold
                        .size(AppFontSize.size18)
                        .make(),
                    5.heightBox,
                    doc['docTimeing']
                        .toString()
                        .text
                        .size(AppFontSize.size14)
                        .make(),
                    10.heightBox,
                    "Searvices".text.semiBold.size(AppFontSize.size18).make(),
                    5.heightBox,
                    doc['docService']
                        .toString()
                        .text
                        .size(AppFontSize.size14)
                        .make(),
                    25.heightBox,
                    ListTile(
                      title: "Contact Details"
                          .text
                          .semiBold
                          .size(AppFontSize.size16)
                          .make(),
                      subtitle: "First book an Appointment for contact details"
                          .text
                          .size(AppFontSize.size12)
                          .make(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _buildReviewSection(context),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        child: CoustomButton(
            onTap: () {
              Get.to(
                () => BookAppointmentView(
                  docId: doc['docId'],
                  docName: doc['docName'],
                  docNum: doc['docPhone'],
                ),
              );
            },
            title: "Book an Appointment"),
      ),
    );
  }

  Widget _buildReviewSection(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('doctors')
          .doc(doc.id)
          .collection('reviews')
          .orderBy('rating', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return "No reviews available".text.makeCentered();
        }

        var reviews = snapshot.data!.docs;

        // Only display up to 5 reviews, or fewer if there are less than 5
        int reviewCount = reviews.length > 5 ? 5 : reviews.length;

        return SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: reviewCount,
            itemBuilder: (context, index) {
              var review = reviews[index];
              return buildReviewCard(review);
            },
          ),
        );
      },
    );
  }
}
