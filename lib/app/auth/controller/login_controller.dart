import 'package:s_medi/general/consts/consts.dart';

class LoginController extends GetxController {
  UserCredential? userCredential;
  var isLoading = false.obs;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  loginUser(context) async {
    try {
      isLoading(true);
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      isLoading(false);
      VxToast.show(context, msg: "Login Sucessfull");
    } catch (e) {
      isLoading(false);
      VxToast.show(context, msg: "wrong email or password");
    }
  }
}
