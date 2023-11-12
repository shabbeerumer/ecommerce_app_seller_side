import 'package:flutter_e_commerce_app_seller_side/const/const.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/texts.dart';

Widget textformfield({hint, lable, controller, isdes = false}) {
  return TextFormField(
    style: TextStyle(color: white),
    controller: controller,
    maxLines: isdes ? 4 : 1,
    decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        hintStyle: TextStyle(color: lightGrey),
        label: normaltext(text: lable),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(12))),
  );
}
