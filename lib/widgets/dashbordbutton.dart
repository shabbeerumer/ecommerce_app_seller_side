import 'package:flutter_e_commerce_app_seller_side/const/const.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/mediaquery.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/texts.dart';

Widget dashbordbutton(context, {text, count, icon}) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: purpleColor, borderRadius: BorderRadius.circular(10)),
    height: MediaQueryu.getScreenHeight(context) * .15,
    width: MediaQueryu.getScreenWidth(context) * .40,
    child: Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boldtext(text: text),
              boldtext(text: count),
            ],
          ),
        ),
        Image.asset(
          icon,
          width: 40,
        )
      ],
    ),
  );
}
