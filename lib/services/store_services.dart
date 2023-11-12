import 'package:flutter_e_commerce_app_seller_side/const/firebase_const.dart';

class storeservices {
  static getproducts(uid) {
    return firestore.collection('venders').where('id', isEqualTo: uid).get();
  }

  static getmessages(uid) {
    return firestore
        .collection('chats')
        .where('toid', isEqualTo: uid)
        .snapshots();
  }

  static getorders(uid) {
    return firestore
        .collection('orders')
        .where('venders', arrayContains: uid)
        .snapshots();
  }

  static getallproducts(uid) {
    return firestore
        .collection('products')
        .where('vender_id', isEqualTo: uid)
        .snapshots();
  }
}
