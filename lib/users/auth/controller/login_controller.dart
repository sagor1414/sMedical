import 'package:s_medi/general/consts/consts.dart';

class LoginController extends GetxController {
  UserCredential? userCredential;
  var isLoading = false.obs;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  //login if user enter validate email and password
  loginUser(context) async {
    if (formkey.currentState!.validate()) {
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

  //validate email and password
  String? validateemail(value) {
    if (value!.isEmpty) {
      return 'please enter an email';
    }
    RegExp emailRefExp = RegExp(r'^[\w\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRefExp.hasMatch(value)) {
      return 'please enter a valied email';
    }
    return null;
  }

  String? validpass(value) {
    if (value!.isEmpty) {
      return 'please enter a password';
    }
    RegExp emailRefExp = RegExp(r'^.{8,}$');
    if (!emailRefExp.hasMatch(value)) {
      return 'Password Must Contain At Least 8 Characters';
    }
    return null;
  }
}
