import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_e_commerce_app_seller_side/modals/categoriemodal.dart';
import 'package:image_picker/image_picker.dart';
import '../const/const.dart';
import 'home_controller.dart';

class product_controller {
  var categorylist = <String>[];
  var subcategorylist = <String>[];
  var category = [];
  var pimagelist = List<dynamic>.generate(3, (index) => null);
  var categotyvalue = '';
  var subcategotyvalue = '';
  var selectedcolorindex = 0;
  var pimagelink = [];
  TextEditingController productnamecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController quentitycontroller = TextEditingController();
  home_controller hc = home_controller();
  getcategory() async {
    var data =
        await rootBundle.loadString('lib/services/categorie_model.json.dart');
    var jsonData = json.decode(data);
    var cat = Categoriemodal.fromJson(jsonData);
    category = cat.categories!;
  }

  populatecategorylist() {
    categorylist.clear();
    for (var item in category) {
      categorylist.add(item.name);
    }
  }

  populatesubcategory(cat) {
    subcategorylist.clear(); // Clear the existing subcategories
    var data = category.where((element) => element.name == cat).toList();
    for (int i = 0; i < data.first.subcategory.length; i++) {
      subcategorylist.add(data.first.subcategory[i]);
    }
  }

  pickimage(index, context) async {
    try {
      var img = await ImagePicker().pickImage(source: ImageSource.camera);
      if (img == null) {
        return null;
      } else {
        pimagelist[index] = File(img.path);
      }
    } catch (e) {
      VxToast.show(context, msg: 'some things wants wrong');
    }
  }

  // uploadimage() async {
  //   pimagelink.clear();
  //   for (var item in pimagelist) {
  //     if (item == null) {
  //       return null;
  //     } else {
  //       FirebaseStorage _storage = FirebaseStorage.instance;
  //       Reference storageRef =
  //           _storage.ref().child('images/venders${user!.uid.toString()}.jpg');
  //       UploadTask uploadTask = storageRef.putFile(item);
  //       TaskSnapshot downloadUrl = await uploadTask;
  //       final url = await downloadUrl.ref.getDownloadURL();
  //       pimagelink.add(url);
  //     }
  //   }
  // }

  uploadimage() async {
    List<String> tempLinks = [];

    for (var item in pimagelist) {
      if (item != null) {
        FirebaseStorage _storage = FirebaseStorage.instance;
        Reference storageRef =
            _storage.ref().child('images/venders${user!.uid.toString()}.jpg');
        UploadTask uploadTask = storageRef.putFile(item);
        TaskSnapshot downloadUrl = await uploadTask;
        final url = await downloadUrl.ref.getDownloadURL();
        tempLinks.add(url);
      }
    }
    pimagelink.clear();
    pimagelink.addAll(tempLinks);
    print(pimagelink);
  }

  uploadproducts(context) async {
    await firestore.collection('products').doc().set({
      'is_featured': false,
      'p_catogery': categotyvalue,
      'p_subcategory': subcategotyvalue,
      'p_colors': FieldValue.arrayUnion([golden.value, red.value, green.value]),
      'p_images': FieldValue.arrayUnion(pimagelink),
      'p_wishlist': FieldValue.arrayUnion([]),
      'p_description': descriptioncontroller.text,
      'p_name': productnamecontroller.text,
      'p_price': pricecontroller.text,
      'p_quantity': quentitycontroller.text,
      'p_seller': hc.username,
      'p_rating': '5.0',
      'vender_id': user!.uid,
      'featured_id': '',
    });
    VxToast.show(context, msg: 'product uploaded successfully');
  }

  addfeatured(docid) async {
    await firestore.collection('products').doc(docid).set(
        {'featured_id': user!.uid, 'is_featured': true},
        SetOptions(merge: true));
  }

  removefeatured(docid) async {
    await firestore.collection('products').doc(docid).set(
        {'featured_id': '', 'is_featured': false}, SetOptions(merge: true));
  }

  removeproduct(docid) async {
    await firestore.collection('products').doc(docid).delete();
  }
}
