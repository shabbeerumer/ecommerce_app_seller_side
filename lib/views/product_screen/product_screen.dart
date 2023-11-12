import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_e_commerce_app_seller_side/const/const.dart';
import 'package:flutter_e_commerce_app_seller_side/views/product_screen/add_products.dart';
import 'package:flutter_e_commerce_app_seller_side/views/product_screen/product_detail_screen.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/appbar.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/mediaquery.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/texts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_e_commerce_app_seller_side/services/store_services.dart';
import '../../controllers/product_controller.dart';
import '../../widgets/lodingindicator.dart';

class product_screen extends StatefulWidget {
  const product_screen({Key? key}) : super(key: key);

  @override
  State<product_screen> createState() => _product_screenState();
}

class _product_screenState extends State<product_screen> {
  product_controller pc = product_controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: purpleColor,
        onPressed: () async {
          await pc.getcategory(); // Await here
          pc.populatecategorylist();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => add_products(
                        categorylist: pc.categorylist,
                        subcategorylist: pc.subcategorylist,
                      )));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: appbar('products'),
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
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
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
                            subtitle: Row(
                              children: [
                                normaltext(
                                    text: data[index]['p_price'],
                                    color: Colors.black),
                                SizedBox(
                                  width:
                                      MediaQueryu.getScreenWidth(context) * .01,
                                ),
                                boldtext(
                                    text: data[index]['is_featured'] == true
                                        ? 'featured'
                                        : '',
                                    color: green),
                              ],
                            ),
                            leading: Image.network(
                              data[index]['p_images'][0].toString(),
                              width: 100,
                              height: 100,
                            ),
                            trailing: VxPopupMenu(
                                arrowSize: 0.0,
                                child: Icon(Icons.more_vert_outlined),
                                menuBuilder: () => Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: EdgeInsets.all(10),
                                      width: 200,
                                      child: Column(
                                        children: List.generate(
                                            poupopmenutitle.length,
                                            (i) => Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      switch (i) {
                                                        case 0:
                                                          if (data[index][
                                                                  'is_featured'] ==
                                                              true) {
                                                            pc.removefeatured(
                                                                data[index].id);
                                                            VxToast.show(
                                                                context,
                                                                msg:
                                                                    'featured removed');
                                                          } else {
                                                            pc.addfeatured(
                                                                data[index].id);
                                                            VxToast.show(
                                                                context,
                                                                msg:
                                                                    'featured added');
                                                          }
                                                          break;
                                                        case 1:
                                                          break;
                                                        case 2:
                                                          pc.removeproduct(
                                                              data[index].id);
                                                          VxToast.show(context,
                                                              msg:
                                                                  'product removed');
                                                          break;
                                                      }
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          poupopmenuicon[i],
                                                          color: data[index][
                                                                          'featured_id']! ==
                                                                      user!
                                                                          .uid &&
                                                                  i == 0
                                                              ? Colors.green
                                                              : Colors.grey,
                                                        ),
                                                        SizedBox(
                                                          width: MediaQueryu
                                                                  .getScreenWidth(
                                                                      context) *
                                                              .01,
                                                        ),
                                                        normaltext(
                                                            text: data[index][
                                                                            'featured_id']! ==
                                                                        user!
                                                                            .uid &&
                                                                    i == 0
                                                                ? 'Remove featured'
                                                                : poupopmenutitle[
                                                                    i],
                                                            color: Colors.black)
                                                      ],
                                                    ),
                                                  ),
                                                )),
                                      ),
                                    ),
                                clickType: VxClickType.singleClick)))),
              );
            } else {
              return Center(
                  child: Text(
                'No products found!',
                style: TextStyle(fontSize: 20),
              ));
            }
          }),
    );
  }
}
