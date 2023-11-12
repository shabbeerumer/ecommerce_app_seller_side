import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app_seller_side/const/colors.dart';
import 'package:flutter_e_commerce_app_seller_side/const/const.dart';
import 'package:flutter_e_commerce_app_seller_side/views/product_screen/components/products_images.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/mediaquery.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/textformfield.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/texts.dart';
import '../../controllers/product_controller.dart';

class add_products extends StatefulWidget {
  var categorylist;
  var subcategorylist;
  add_products({
    Key? key,
    required this.categorylist,
    required this.subcategorylist,
  }) : super(key: key);

  @override
  State<add_products> createState() => _add_productsState();
}

class _add_productsState extends State<add_products> {
  product_controller pc = product_controller();
  var selectedcolorindex = 0;

  @override
  Widget build(BuildContext context) {
    print(widget.categorylist);
    print(widget.subcategorylist);
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: purpleColor,
        actions: [
          TextButton(
              onPressed: () async {
                await pc.uploadimage();
                await pc.uploadproducts(context);
                Navigator.pop(context);
              },
              child: boldtext(
                text: 'save',
              ))
        ],
        title: normaltext(
          text: 'Add Product',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textformfield(
                  hint: 'eg dress',
                  lable: 'product name',
                  controller: pc.productnamecontroller),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * .01,
              ),
              textformfield(
                  hint: 'eg nice products',
                  lable: 'description',
                  isdes: true,
                  controller: pc.descriptioncontroller),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * .01,
              ),
              textformfield(
                  hint: 'eg 100',
                  lable: 'price',
                  controller: pc.pricecontroller),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * .01,
              ),
              textformfield(
                  hint: 'eg 20',
                  lable: 'quantity',
                  controller: pc.quentitycontroller),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * .01,
              ),
              productdropdown(
                  'category', widget.categorylist, pc.categotyvalue, pc),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * .01,
              ),
              productdropdown('subcategory', widget.subcategorylist,
                  pc.subcategotyvalue, pc),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * .01,
              ),
              Divider(
                color: white,
              ),
              boldtext(text: 'choose product image'),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                        3,
                        (index) => pc.pimagelist[index] == null
                            ? productimages(lable: "${index + 1}")
                                .onTap(() async {
                                await pc.pickimage(index, context);
                                setState(() {});
                              })
                            : Image.file(
                                pc.pimagelist[index],
                                width: 100,
                              ).onTap(() {
                                pc.pickimage(index, context);
                              }))),
              ),
              normaltext(text: 'first image will be your display'),
              Divider(),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * .01,
              ),
              boldtext(text: 'choose product color'),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * .01,
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: List.generate(
                    9,
                    (index) => Stack(alignment: Alignment.center, children: [
                          VxBox()
                              .color(Vx.randomPrimaryColor)
                              .roundedFull
                              .size(40, 40)
                              .make()
                              .onTap(() {
                            setState(() {
                              selectedcolorindex = index;
                            });
                          }),
                          selectedcolorindex == index
                              ? Icon(
                                  Icons.done,
                                  color: white,
                                )
                              : SizedBox()
                        ])),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget productdropdown(
      hint, List<String> list, dropvalue, product_controller controller) {
    return Container(
        color: white,
        child: DropdownButton(
          hint: Text(hint),
          value: (dropvalue.isEmpty) ? null : dropvalue,
          isExpanded: true,
          items: list.map((e) {
            return DropdownMenuItem(
              child: Text(e, style: TextStyle(color: Colors.black)),
              value: e,
            );
          }).toList(),
          onChanged: (newvalue) {
            if (hint == 'category') {
              controller.subcategotyvalue = '';
              controller.populatesubcategory(newvalue.toString());
            }
            setState(() {
              dropvalue = newvalue.toString();
            });
          },
        ));
  }
}
