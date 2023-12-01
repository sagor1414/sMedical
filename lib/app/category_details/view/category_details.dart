import '../../../general/consts/consts.dart';

class CategoryDetailsView extends StatelessWidget {
  const CategoryDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenColor,
        title: "Total Doctors".text.make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 200,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 10,
          itemBuilder: (BuildContext context, index) {
            return Container(
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
                      width: 130,
                      color: AppColors.greenColor,
                      child: Image.asset(
                        AppAssets.imgLogin,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Divider(),
                  "Doctor name".text.size(AppFontSize.size16).make(),
                  VxRating(
                    onRatingUpdate: (value) {},
                    maxRating: 5,
                    count: 5,
                    value: 4,
                    stepInt: true,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
