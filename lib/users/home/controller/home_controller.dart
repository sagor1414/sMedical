import 'package:s_medi/general/consts/consts.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var userName = '....'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    try {
      isLoading.value = true;
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();

      if (userDoc.exists) {
        userName.value = userDoc.data()?['fullname'] ?? 'user';
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getDoctorList() async {
    var doctors = FirebaseFirestore.instance
        .collection('doctors')
        .orderBy('docRating', descending: false)
        .limit(5)
        .get();
    return doctors;
  }
}
