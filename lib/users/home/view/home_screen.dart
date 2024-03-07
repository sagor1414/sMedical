import 'package:s_medi/general/consts/consts.dart';

import '../../../general/list/home_icon_list.dart';
import '../../category_details/view/category_details.dart';
import '../../doctor_profile/view/doctor_view.dart';
import '../../search/controller/search_controller.dart';
import '../../search/view/search_view.dart';
import '../../widgets/coustom_textfield.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var searchcontroller = Get.put(DocSearchController());
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
                      textcontroller: searchcontroller.searchQueryController,
                      hint: AppString.search,
                      icon: const Icon(Icons.person_search_sharp),
                    ),
                  ),
                  10.widthBox,
                  IconButton(
                      onPressed: () {
                        Get.to(() => SearchView(
                              searchQuery:
                                  searchcontroller.searchQueryController.text,
                            ));
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
            ),
            4.heightBox,
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  SizedBox(
                    height: 110,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: iconList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          //ontap for list
                          onTap: () {
                            Get.to(() => CategoryDetailsView(
                                catName: iconListTitle[index]));
                          },
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
                  FutureBuilder<QuerySnapshot>(
                    future: controller.getDoctorList(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        var data = snapshot.data?.docs;
                        return SizedBox(
                          height: 195,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: data?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => DoctorProfile(
                                        doc: data[index],
                                      ));
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
                                      data![index]['docName']
                                          .toString()
                                          .text
                                          .size(AppFontSize.size16)
                                          .make(),
                                      data[index]['docCategory']
                                          .toString()
                                          .text
                                          .size(AppFontSize.size12)
                                          .make(),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
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
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 110,
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
                      Container(
                        padding: const EdgeInsets.all(6),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 110,
                        child: Column(
                          children: [
                            Image.asset(
                              AppAssets.icBody,
                              width: context.screenWidth * .16,
                            ),
                            5.heightBox,
                            "Xry report".text.make()
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 110,
                        child: Column(
                          children: [
                            Image.asset(
                              AppAssets.icBody,
                              width: context.screenWidth * .16,
                            ),
                            5.heightBox,
                            "Mri report".text.make()
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 110,
                        child: Column(
                          children: [
                            Image.asset(
                              AppAssets.icBody,
                              width: context.screenWidth * .16,
                            ),
                            5.heightBox,
                            "Others".text.make()
                          ],
                        ),
                      ),
                    ],
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
