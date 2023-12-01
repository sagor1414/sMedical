import 'package:s_medi/general/consts/consts.dart';

class Appointmentdetails extends StatelessWidget {
  const Appointmentdetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenColor,
        title: "Details".text.make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: context.screenWidth,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.bgDarkColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Doctor name".text.semiBold.make(),
              "name".text.make(),
              10.heightBox,
              "Appointment date".text.semiBold.make(),
              "11/12/23".text.make(),
              10.heightBox,
              "Appointment time".text.semiBold.make(),
              "11:00 Am".text.make(),
              10.heightBox,
              "patient's name".text.semiBold.make(),
              "naymer".text.make(),
              10.heightBox,
              "patient's phone".text.semiBold.make(),
              "+880174444".text.make(),
              10.heightBox,
              "Problems".text.semiBold.make(),
              "i_have fever for 2 days".text.make(),
              10.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
