import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_e_commerce_app_seller_side/const/const.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/appbar.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/lodingindicator.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/mediaquery.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/texts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_e_commerce_app_seller_side/services/store_services.dart';
import 'order_detail_screen.dart';

class order_screen extends StatefulWidget {
  const order_screen({Key? key}) : super(key: key);

  @override
  State<order_screen> createState() => _order_screenState();
}

class _order_screenState extends State<order_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('orders'),
      body: StreamBuilder<QuerySnapshot>(
          stream: storeservices.getorders(user!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: lodingindicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Some Things Wants Wrong'));
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(data.length, (index) {
                      var time = data[index]['order_date'].toDate();
                      return Container(
                        margin: EdgeInsets.only(bottom: 4),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          tileColor: textfieldGrey,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => order_detail_screen(
                                          data: data[index],
                                        )));
                          },
                          title: boldtext(
                              text: data[index]['order_code'],
                              color: purpleColor),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.calendar_month),
                                  SizedBox(
                                    width: MediaQueryu.getScreenWidth(context) *
                                        .01,
                                  ),
                                  boldtext(
                                      text: intl.DateFormat()
                                          .add_yMd()
                                          .format(time)
                                          .toString(),
                                      color: fontGrey),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.payment),
                                  SizedBox(
                                    width: MediaQueryu.getScreenWidth(context) *
                                        .01,
                                  ),
                                  boldtext(text: 'unpaid', color: red),
                                ],
                              ),
                            ],
                          ),
                          trailing: boldtext(
                              text:
                                  "\$${data[index]['total_amount'].toString()}",
                              color: fontGrey),
                        ),
                      );
                    }),
                  ),
                ),
              );
            } else {
              return Center(
                  child: Text(
                'No orders found!',
                style: TextStyle(fontSize: 20),
              ));
            }
          }),
    );
  }
}
