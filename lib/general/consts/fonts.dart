import 'package:s_medi/general/consts/consts.dart';

class AppFontSize {
  static const size12 = 12.0,
      size14 = 14.0,
      size16 = 16.0,
      size18 = 18.0,
      size20 = 20.0,
      size22 = 22.0,
      size34 = 34.0;
}

class AppStyle {
  static normal({String? title, double? size}) {
    return title!.text.size(size).make();
  }

  static bold({String? title, double? size}) {
    return title!.text.size(size).semiBold.make();
  }
}
