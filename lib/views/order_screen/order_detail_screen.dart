import 'package:flutter_e_commerce_app_seller_side/const/const.dart';
import 'package:flutter_e_commerce_app_seller_side/views/order_screen/components/orderplacedetail.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/mediaquery.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/ourbutton.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/texts.dart';
import 'package:intl/intl.dart' as intl;

import '../../controllers/order_controller.dart';

class order_detail_screen extends StatefulWidget {
  var data;
  order_detail_screen({Key? key, required this.data}) : super(key: key);

  @override
  State<order_detail_screen> createState() => _order_detail_screenState();
}

class _order_detail_screenState extends State<order_detail_screen> {
  ordercontroller oc = ordercontroller();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    oc.getorder(widget.data);
    conformed = widget.data['order_confirmed'];
    dilevered = widget.data['order_delivered'];
    ondelivery = widget.data['order_on_delivery'];
  }

  var conformed = false;
  var ondelivery = false;
  var dilevered = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Visibility(
        visible: !conformed,
        child: SizedBox(
          height: 60,
          width: double.infinity,
          child: ourbutton(
              text: 'Conform order',
              context: context,
              onpress: () {
                setState(() {
                  conformed = true;
                });
                oc.changestatus(
                    title: 'order_confirmed',
                    status: true,
                    docid: widget.data.id);
              },
              color: green),
        ),
      ),
      appBar: AppBar(title: Text('Order Detail')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Visibility(
                visible: conformed,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: lightGrey,
                        offset: Offset(0, 1), // X and Y offsets for the shadow
                        blurRadius: 2.0, // Spread of the shadow
                        spreadRadius: 1.0,
                        blurStyle: BlurStyle
                            .outer // Positive values will expand the shadow
                        ),
                  ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldtext(
                          text: 'Order status', color: fontGrey, siza: 19.0),
                      SwitchListTile(
                        activeColor: green,
                        value: true,
                        onChanged: (value) {},
                        title: boldtext(
                          text: 'placed',
                          color: fontGrey,
                        ),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: conformed,
                        onChanged: (value) {
                          setState(() {
                            conformed = value;
                          });
                        },
                        title: boldtext(
                          text: 'Conformed',
                          color: fontGrey,
                        ),
                      ),
                      SwitchListTile(
                        value: dilevered,
                        activeColor: green,
                        onChanged: (value) {
                          setState(() {
                            dilevered = value;
                          });
                          oc.changestatus(
                              title: 'order_delivered',
                              status: value,
                              docid: widget.data.id);
                        },
                        title: boldtext(
                          text: 'Delivery',
                          color: fontGrey,
                        ),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: ondelivery,
                        onChanged: (value) {
                          setState(() {
                            ondelivery = value;
                          });
                          oc.changestatus(
                              title: 'order_on_delivery',
                              status: value,
                              docid: widget.data.id);
                        },
                        title: boldtext(
                          text: 'On Delivered',
                          color: fontGrey,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: lightGrey,
                      offset: Offset(0, 1), // X and Y offsets for the shadow
                      blurRadius: 4.0, // Spread of the shadow
                      spreadRadius: 2.0,
                      blurStyle: BlurStyle
                          .outer // Positive values will expand the shadow
                      ),
                ]),
                child: Column(
                  children: [
                    orderplacedetail(
                      'Order code',
                      widget.data['order_code'],
                      'Shipping Method',
                      widget.data['shipping_method'],
                    ),
                    SizedBox(
                      height: MediaQueryu.getScreenHeight(context) * 0.01,
                    ),
                    orderplacedetail(
                      'Order date',
                      intl.DateFormat()
                          .add_yMd()
                          .format(widget.data['order_date'].toDate()),
                      'Payment Method',
                      widget.data['payment_method'],
                    ),
                    SizedBox(
                      height: MediaQueryu.getScreenHeight(context) * 0.01,
                    ),
                    orderplacedetail('Payment Status', 'unpaid',
                        'Delivery Status', 'Order Status'),
                    SizedBox(
                      height: MediaQueryu.getScreenHeight(context) * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Shipping Address'),
                            Text(
                              widget.data['order_by_name'],
                            ),
                            Text(
                              widget.data['order_by_email'],
                            ),
                            Text(
                              widget.data['order_by_address'],
                            ),
                            Text(
                              widget.data['order_by_city'],
                            ),
                            Text(
                              widget.data['order_by_state'],
                            ),
                            Text(
                              widget.data['order_by_phone'],
                            ),
                            Text(
                              widget.data['order_by_postalcode'],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total Ammount'),
                            Text(
                              "\$${widget.data['total_amount'].toString()}",
                              style: TextStyle(color: red),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.02,
              ),
              const Text(
                'Ordered Product',
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.01,
              ),
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: lightGrey,
                      offset: Offset(0, 1), // X and Y offsets for the shadow
                      blurRadius: 4.0, // Spread of the shadow
                      spreadRadius: 2.0,
                      blurStyle: BlurStyle
                          .outer // Positive values will expand the shadow
                      ),
                ]),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(oc.orders.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderplacedetail(
                            oc.orders[index]['title'],
                            oc.orders[index]['tprice'].toString(),
                            '${oc.orders[index]['qty']}x',
                            'Refundable'),
                        Container(
                            width: 30,
                            height: 20,
                            color: Color(int.parse(oc.orders[index]['color']))),
                        Divider()
                      ],
                    );
                  }),
                ),
              ),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
