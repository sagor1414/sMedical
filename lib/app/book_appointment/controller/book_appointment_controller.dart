import 'package:s_medi/general/consts/consts.dart';

class AppointmentController extends GetxController {
  var isLoading = false.obs;
  var appDayController = TextEditingController();
  var appTimeController = TextEditingController();
  var appNameController = TextEditingController();
  var appMobileController = TextEditingController();
  var appMessageController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bookAppointment(String docId, String docName, String docNum, context) async {
    if (formkey.currentState!.validate()) {
      try {
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
          'appDocName': docName,
          'appDocNum': docNum,
        });
        isLoading(false);
        VxToast.show(context, msg: "Appointment is booked sucessfully");
        Get.back();
      } catch (e) {
        VxToast.show(context, msg: "$e");
      }
    }
  }

  String? validdata(value) {
    if (value!.isEmpty) {
      return 'please fill this';
    }
    RegExp emailRefExp = RegExp(r'^.{3,}$');
    if (!emailRefExp.hasMatch(value)) {
      return 'Enter valid data';
    }
    return null;
  }
}
