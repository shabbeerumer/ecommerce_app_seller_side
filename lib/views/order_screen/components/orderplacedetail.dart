import 'package:flutter_e_commerce_app_seller_side/const/const.dart';

orderplacedetail(title1, data1, title2, data2) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title1),
          Text(
            data1,
            style: const TextStyle(color: red),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title2),
          Text(data2),
        ],
      ),
    ],
  );
}
