import 'package:s_medi/app/widgets/coustom_textfield.dart';
import 'package:s_medi/general/consts/consts.dart';

import '../../widgets/coustom_button.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 35),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Column(
              children: [
                Image.asset(
                  AppAssets.imgWelcome,
                  width: context.screenHeight * .23,
                ),
                8.heightBox,
                AppString.signupNow.text
                    .size(AppFontSize.size18)
                    .semiBold
                    .make()
              ],
            ),
            15.heightBox,
            Expanded(
              flex: 2,
              child: Form(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    CoustomTextField(
                      hint: AppString.fullName,
                      icon: const Icon(Icons.person),
                    ),
                    15.heightBox,
                    CoustomTextField(
                      icon: const Icon(Icons.email_outlined),
                      hint: AppString.emailHint,
                    ),
                    15.heightBox,
                    CoustomTextField(
                      icon: const Icon(Icons.key),
                      hint: AppString.passwordHint,
                    ),
                    20.heightBox,
                    SizedBox(
                      width: context.screenWidth * .7,
                      height: 44,
                      child: CoustomButton(
                        title: AppString.signup,
                        onTap: () {},
                      ),
                    ),
                    20.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppString.alreadyHaveAccount.text.make(),
                        8.widthBox,
                        AppString.login.text.make().onTap(() {
                          Get.back();
                        }),
                      ],
                    )
                  ],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
