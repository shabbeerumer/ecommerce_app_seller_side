import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_e_commerce_app_seller_side/const/const.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/appbar.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/dashbordbutton.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/mediaquery.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/texts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_e_commerce_app_seller_side/services/store_services.dart';

import '../../widgets/lodingindicator.dart';
import '../product_screen/product_detail_screen.dart';

class dashbord_screen extends StatefulWidget {
  const dashbord_screen({Key? key}) : super(key: key);

  @override
  State<dashbord_screen> createState() => _dashbord_screenState();
}

class _dashbord_screenState extends State<dashbord_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar('dashbord'),
        body: StreamBuilder<QuerySnapshot>(
            stream: storeservices.getallproducts(user!.uid),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          dashbordbutton(context,
                              text: 'products',
                              count: data.length.toString(),
                              icon: 'assets/icons/products.png'),
                          dashbordbutton(context,
                              text: 'orders',
                              count: '1',
                              icon: 'assets/icons/orders.png')
                        ],
                      ),
                      SizedBox(
                        height: MediaQueryu.getScreenHeight(context) * .01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          dashbordbutton(context,
                              text: 'ratings',
                              count: '11',
                              icon: 'assets/icons/star.png'),
                          dashbordbutton(context,
                              text: 'total sales',
                              count: '11',
                              icon: 'assets/icons/products.png')
                        ],
                      ),
                      SizedBox(
                        height: MediaQueryu.getScreenHeight(context) * .01,
                      ),
                      Divider(),
                      SizedBox(
                        height: MediaQueryu.getScreenHeight(context) * .01,
                      ),
                      boldtext(
                          text: 'popular products',
                          color: Colors.black,
                          siza: 20.0),
                      ListView(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                              data.length,
                              (index) => ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  product_detail_screen(
                                                    data: data[index],
                                                  )));
                                    },
                                    title: boldtext(
                                        text: data[index]['p_name'],
                                        color: Colors.black),
                                    subtitle: boldtext(
                                        text: data[index]['p_price'],
                                        color: Colors.black),
                                    leading: Image.network(
                                      data[index]['p_images'][0],
                                      width: 100,
                                      height: 100,
                                    ),
                                  )))
                    ],
                  ),
                );
              } else {
                return Center(
                    child: Text(
                  'No products found!',
                  style: TextStyle(fontSize: 20),
                ));
              }
            }));
  }
}
