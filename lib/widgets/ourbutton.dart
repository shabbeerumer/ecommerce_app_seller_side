import 'package:flutter_e_commerce_app_seller_side/const/const.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/mediaquery.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/texts.dart';

Widget ourbutton({
  text,
  context,
  onpress,
  color = purpleColor,
}) {
  return InkWell(
    onTap: onpress,
    child: Container(
      height: MediaQueryu.getScreenHeight(context) * .07,
      width: MediaQueryu.getScreenWidth(context) * .75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      child: Center(child: normaltext(text: text)),
    ),
  );
}
