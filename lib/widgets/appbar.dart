import 'package:flutter_e_commerce_app_seller_side/const/const.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/texts.dart';
import 'package:intl/intl.dart' as intl;

AppBar appbar(title) {
  return AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    title: boldtext(text: title, color: Colors.black),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: boldtext(
            text: intl.DateFormat("EEE, MMM d, ''yy")
                .format(DateTime.now())
                .toString(),
            color: Colors.black),
      ),
    ],
  );
}
