import 'package:flutter_e_commerce_app_seller_side/const/const.dart';

Widget normaltext({text, siza, color = Colors.white}) {
  return Text(text, style: TextStyle(fontSize: siza, color: color));
}

Widget boldtext({text, siza, color = Colors.white}) {
  return Text(text,
      style:
          TextStyle(fontSize: siza, color: color, fontWeight: FontWeight.bold));
}
