import 'package:s_medi/general/consts/consts.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    getData = getUserData();
    super.onInit();
  }

  var isLoading = false.obs;
  var currentUser = FirebaseAuth.instance.currentUser;
  var username = ''.obs;
  var email = ''.obs;
  Future? getData;

  getUserData() async {
    isLoading(true);
    DocumentSnapshot<Map<String, dynamic>> user = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
    var userData = user.data();
    username.value = userData!['fullname'] ?? "";
    email.value = currentUser!.email ?? "";
    isLoading(false);
  }
}
