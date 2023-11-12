import '../const/firebase_const.dart';

class home_controller {
  var username = '';
  getusername() async {
    var value = await firestore
        .collection('venders')
        .where('id', isEqualTo: user!.uid)
        .get();

    if (value.docs.isNotEmpty) {
      username = value.docs.single['vender_name'];
    }
  }
}
