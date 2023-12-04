import 'package:s_medi/general/consts/consts.dart';

class AppointmentController extends GetxController {
  var isLoading = false.obs;
  var appDayController = TextEditingController();
  var appTimeController = TextEditingController();
  var appNameController = TextEditingController();
  var appMobileController = TextEditingController();
  var appMessageController = TextEditingController();

  bookAppointment(String docId, context) async {
    isLoading(true);
    var store = FirebaseFirestore.instance.collection('appointments').doc();
    await store.set({
      'appBy': FirebaseAuth.instance.currentUser?.uid,
      'appDay': appDayController.text,
      'appTime': appTimeController.text,
      'appName': appNameController.text,
      'appMobile': appMobileController.text,
      'appMsg': appMessageController.text,
      'appWith': docId,
    });
    isLoading(false);
    VxToast.show(context, msg: "Appointment is booked sucessfully");
    Get.back();
  }
}
