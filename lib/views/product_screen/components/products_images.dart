import 'package:flutter_e_commerce_app_seller_side/const/const.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/texts.dart';

Widget productimages({required lable, onpress}) {
  return Container(
      height: 100,
      width: 100,
      decoration:
          BoxDecoration(color: white, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          lable,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ));
}
