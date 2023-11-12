import 'package:flutter_e_commerce_app_seller_side/const/const.dart';

class MediaQueryu {
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
