import 'package:s_medi/general/consts/consts.dart';
import 'package:s_medi/general/list/home_icon_list.dart';

import '../../category_details/view/category_details.dart';

class CategoryScreenn extends StatelessWidget {
  const CategoryScreenn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenColor,
        title: "Total Categoty".text.make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: categoryImage.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            crossAxisCount: 2,
            mainAxisExtent: 200,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => CategoryDetailsView(
                      catName: categoryTitle[index],
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.bgDarkColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(12),
                // margin: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: [
                    Image.asset(
                      categoryImage[index],
                      width: 110,
                    ),
                    const Divider(),
                    categoryTitle[index].text.size(AppFontSize.size18).make(),
                    "13 Specialists".text.make()
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
