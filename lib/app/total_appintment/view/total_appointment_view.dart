import '../../../general/consts/consts.dart';
import '../../appointment_details/view/appointment_details.dart';

class TotalAppointment extends StatelessWidget {
  const TotalAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenColor,
        title: "All Appointmnets".text.make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, index) {
              return ListTile(
                onTap: () {
                  Get.to(() => const Appointmentdetails());
                },
                leading: CircleAvatar(
                  child: ClipOval(
                    child: Image.asset(
                      AppAssets.imgDoctor,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                title: "Doctor name".text.semiBold.make(),
                subtitle: "Time".text.make(),
              );
            }),
      ),
    );
  }
}
