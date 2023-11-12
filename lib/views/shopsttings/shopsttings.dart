import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_seller_side/const/colors.dart';
import 'package:flutter_e_commerce_app_seller_side/const/const.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/mediaquery.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/textformfield.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/texts.dart';

class shopsettings extends StatefulWidget {
  const shopsettings({Key? key}) : super(key: key);

  @override
  State<shopsettings> createState() => _shopsettingsState();
}

class _shopsettingsState extends State<shopsettings> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController websitecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: normaltext(
          text: 'Shop Setting',
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await updateshop(
                  namecontroller.text,
                  addresscontroller.text,
                  mobilecontroller.text,
                  websitecontroller.text,
                  descriptioncontroller.text);

              VxToast.show(context, msg: 'Shop Updated');
            },
            child: boldtext(
              text: 'save',
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            textformfield(
                hint: 'eg seller name',
                lable: 'name',
                controller: namecontroller),
            SizedBox(
              height: MediaQueryu.getScreenHeight(context) * .02,
            ),
            textformfield(
                hint: 'eg ryk new bazar',
                lable: 'address',
                controller: addresscontroller),
            SizedBox(
              height: MediaQueryu.getScreenHeight(context) * .02,
            ),
            textformfield(
                hint: 'eg +923547450987',
                lable: 'mobile',
                controller: mobilecontroller),
            SizedBox(
              height: MediaQueryu.getScreenHeight(context) * .02,
            ),
            textformfield(
                hint: 'eg seller.mart.com',
                lable: 'website',
                controller: websitecontroller),
            SizedBox(
              height: MediaQueryu.getScreenHeight(context) * .02,
            ),
            textformfield(
                hint: 'Enter your shop description',
                lable: 'Description',
                controller: descriptioncontroller,
                isdes: true),
          ],
        ),
      ),
    );
  }

  updateshop(
      shopname, shopaddress, shopmobile, shopwebsite, shopdescription) async {
    return await firestore.collection('venders').doc(user!.uid).update({
      'shopname': shopname,
      'shopaddress': shopaddress,
      'shopmobile': shopmobile,
      'shopwebsite': shopwebsite,
      'shopdescription': shopdescription,
    });
  }
}
