import 'package:s_medi/doctor/app/auth/view/login_page.dart';

import '../../../general/consts/consts.dart';
import '../controller/total_appointment.dart';

class TotalAppointment extends StatelessWidget {
  const TotalAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put((TotalAppointmentcontroller()));
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await FirebaseAuth.instance.signOut();
        Get.offAll(() => const LoginView());
      }),
      appBar: AppBar(
        backgroundColor: AppColors.greenColor,
        title: "All Appointmnets".text.make(),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: controller.getAppointments(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            // While data is being fetched, display a CircularProgressIndicator.
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var data = snapshot.data?.docs;
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: data?.length ?? 0,
                itemBuilder: (BuildContext context, index) {
                  return ListTile(
                    onTap: () {
                      // Get.to(() => Appointmentdetails(
                      //       doc: data[index],
                      //     ));
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
                    title: data![index]['appDocName']
                        .toString()
                        .text
                        .semiBold
                        .make(),
                    subtitle:
                        "${data[index]['appDay']} - ${data[index]['appTime']}"
                            .toString()
                            .text
                            .make(),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
