import 'package:s_medi/general/consts/consts.dart';
import 'package:s_medi/users/review/view/review_screen.dart';

class Appointmentdetails extends StatelessWidget {
  final DocumentSnapshot doc;
  const Appointmentdetails({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: "Appointment Details".text.make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: context.screenWidth,
              padding: const EdgeInsets.all(15),
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
                    child: Image.asset(
                      AppAssets.imgLogin,
                      fit: BoxFit.cover,
                    ),
                  ),
                  15.widthBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Doctor name"
                          .text
                          .size(AppFontSize.size18)
                          .semiBold
                          .make(),
                      doc['appDocName']
                          .toString()
                          .text
                          .size(AppFontSize.size16)
                          .make(),
                      doc['appDocNum']
                          .toString()
                          .text
                          .size(AppFontSize.size12)
                          .make(),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: 60,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.primeryColor,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            10.heightBox,
            Container(
              width: context.screenWidth,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.bgDarkColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.heightBox,
                  "Appointment day".text.semiBold.make(),
                  doc['appDay'].toString().text.make(),
                  10.heightBox,
                  "Appointment time".text.semiBold.make(),
                  doc['appTime'].toString().text.make(),
                  10.heightBox,
                  "patient's name".text.semiBold.make(),
                  doc['appName'].toString().text.make(),
                  10.heightBox,
                  "patient's phone".text.semiBold.make(),
                  doc['appMobile'].toString().text.make(),
                  10.heightBox,
                  "Problems".text.semiBold.make(),
                  doc['appMsg'].toString().text.make(),
                  30.heightBox,
                  "Status".text.semiBold.make(),
                  doc['status'].toString().text.make(),
                  40.heightBox,
                  doc['status'] == "complete"
                      ? Align(
                          alignment: Alignment.center,
                          child: doc['review'] == "false"
                              ? InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => ReviewPage(
                                        docId: doc['appWith'],
                                        documetId: doc.id,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: AppColors.primeryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Give a Review",
                                        style: TextStyle(
                                          color: AppColors.whiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: AppColors.primeryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Thanks for Review",
                                      style: TextStyle(
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                        )
                      : Container()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
