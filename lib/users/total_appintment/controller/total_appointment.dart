import 'package:s_medi/general/consts/consts.dart';

class TotalAppointmentcontroller extends GetxController {
  var docName = ''.obs;
  var appointments = <QueryDocumentSnapshot<Map<String, dynamic>>>[].obs;
  var isLoading = false.obs;

  Future<QuerySnapshot<Map<String, dynamic>>> getAppointments() async {
    isLoading(true);
    var result = await FirebaseFirestore.instance
        .collection('appointments')
        .where(
          'appBy',
          isEqualTo: FirebaseAuth.instance.currentUser?.uid,
        )
        .get();
    isLoading(false);
    return result;
  }

  Future<void> refreshAppointments() async {
    var result = await getAppointments();
    appointments.assignAll(result.docs);
  }
}
