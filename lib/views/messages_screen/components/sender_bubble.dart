import 'package:flutter_e_commerce_app_seller_side/widgets/texts.dart';
import 'package:intl/intl.dart' as intl;
import '../../../const/const.dart';
// import 'package:intl/intl.dart' as intl;
// import 'package:flutter_e_commerce_app/consts/packege.dart';

Widget sender_babble() {
  // var t =
  // data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  // var time = intl.DateFormat('h:mma').format(t);

  return Directionality(
    // textDirection: data['uid'] == auth.currentUser!.uid
    //     ? TextDirection.rtl
    //     :
    textDirection: TextDirection.rtl,
    child: Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 8, left: 3, right: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20)),
        // color: data['uid'] == auth.currentUser!.uid ? redcolor : greycolor
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          normaltext(text: 'your messages', color: white),
          normaltext(text: '12.03', color: white),
          // Text(
          //   data['msg'],
          //   style: TextStyle(color: whitecolor),
          // ),
          // Text(
          //   time,
          //   style: TextStyle(color: whitecolor),
          // )
        ],
      ),
    ),
  );
}
