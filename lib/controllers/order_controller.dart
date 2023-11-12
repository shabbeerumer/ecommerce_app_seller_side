import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_e_commerce_app_seller_side/const/const.dart';

class ordercontroller {
  var orders = [];
  getorder(data) {
    for (var item in data['orders']) {
      if (item['vender_id'] == user!.uid) {
        orders.add(item);
      }
    }
    print(orders);
  }

  changestatus({title, status, docid}) async {
    var store = firestore.collection('orders').doc(docid);
    await store.set({title: status}, SetOptions(merge: true));
  }
}
