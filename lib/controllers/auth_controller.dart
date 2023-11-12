import 'package:flutter_e_commerce_app_seller_side/views/auth_screen/login_screen.dart';
import 'package:flutter_e_commerce_app_seller_side/views/home/home.dart';

import '../const/const.dart';
import '../const/firebase_const.dart';

Future<void> showuserdata(String name, String email, String password,
    String conformpassword, context) async {
  try {
    await firestore.collection('auth').doc(user!.uid).set({
      'name': name,
      'email': email,
      'password': password,
      'conformpassword': conformpassword,
      'imageurl': '',
      'id': user!.uid,
      'cart count': '00',
      'wishlist count': '00',
      'order count': '00',
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const login_screen()));
  } catch (error) {
    VxToast.show(context, msg: 'Something went wrong');
    throw error; // Throw the error to handle it in the calling code if needed
  }
}

signoutmethod(context) async {
  try {
    await auth.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const login_screen()));
  } catch (error) {
    VxToast.show(context, msg: 'some things wants wrong');
  }
}

loginmethod(String email, String password, context) async {
  try {
    await auth.signInWithEmailAndPassword(email: email, password: password);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const home()));
  } catch (error) {
    VxToast.show(context, msg: 'some things wants wrong');
  }
}
