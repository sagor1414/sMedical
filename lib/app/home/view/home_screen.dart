import 'package:s_medi/app/doctor_profile/view/doctor_view.dart';
import 'package:s_medi/app/widgets/coustom_textfield.dart';
import 'package:s_medi/general/consts/consts.dart';

import '../../../general/list/home_icon_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenColor,
        title: Row(
          children: [
            AppString.welcome.text.make(),
            5.widthBox,
            "User".text.make()
          ],
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            //search section
            Container(
              padding: const EdgeInsets.all(8),
              height: 70,
              color: AppColors.greenColor,
              child: Row(
                children: [
                  Expanded(
                    child: CoustomTextField(
                      hint: AppString.search,
                      icon: const Icon(Icons.person_search_sharp),
                    ),
                  ),
                  10.widthBox,
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search))
                ],
              ),
            ),
            4.heightBox,
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  //some category

                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: iconList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          //ontap for list
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.greenColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            child: Column(
                              children: [
                                Image.asset(
                                  iconList[index],
                                  width: 50,
                                ),
                                5.heightBox,
                                iconListTitle[index].text.make()
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  15.heightBox,
                  //populer doctors
                  Align(
                    alignment: Alignment.centerLeft,
                    child: "Populer Doctors"
                        .text
                        .color(AppColors.greenColor)
                        .size(AppFontSize.size16)
                        .make(),
                  ),
                  10.heightBox,
                  SizedBox(
                    height: 195,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => const DoctorProfile());
                          },
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: AppColors.bgDarkColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.only(bottom: 5),
                            margin: const EdgeInsets.only(right: 8),
                            height: 120,
                            width: 130,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    color: AppColors.greenColor,
                                    child: Image.asset(
                                      AppAssets.imgDoctor,
                                      height: 130,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Divider(),
                                "Doctor name"
                                    .text
                                    .size(AppFontSize.size16)
                                    .make(),
                                "Doctor Category"
                                    .text
                                    .size(AppFontSize.size12)
                                    .make(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  6.heightBox,
                  GestureDetector(
                    onTap: () {},
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: "View All"
                          .text
                          .color(AppColors.primeryColor)
                          .size(AppFontSize.size16)
                          .make(),
                    ),
                  ),
                  20.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      4,
                      (index) => Container(
                        padding: const EdgeInsets.all(6),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 104,
                        child: Column(
                          children: [
                            Image.asset(
                              AppAssets.icBody,
                              width: context.screenWidth * .16,
                            ),
                            5.heightBox,
                            "lab test".text.make()
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
