import 'package:s_medi/general/consts/consts.dart';

class TotalAppointmentcontroller extends GetxController {
  var docName = ''.obs;
  Future<QuerySnapshot<Map<String, dynamic>>> getAppointments() async {
    return FirebaseFirestore.instance
        .collection('appointments')
        .where(
          'appBy',
          isEqualTo: FirebaseAuth.instance.currentUser?.uid,
        )
        .get();
  }
}
