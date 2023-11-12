import 'package:flutter_e_commerce_app_seller_side/const/const.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/mediaquery.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/texts.dart';

class product_detail_screen extends StatefulWidget {
  var data;
  product_detail_screen({Key? key, required this.data}) : super(key: key);

  @override
  State<product_detail_screen> createState() => _product_detail_screenState();
}

class _product_detail_screenState extends State<product_detail_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: normaltext(text: widget.data['p_name'], color: Colors.black)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VxSwiper.builder(
            autoPlay: true,
            height: MediaQueryu.getScreenHeight(context) * 0.4,
            itemCount: widget.data['p_images'].length,
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                widget.data['p_images'][0],
                fit: BoxFit.cover,
              );
            },
          ),
          SizedBox(
            height: MediaQueryu.getScreenHeight(context) * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                normaltext(text: widget.data['p_name'], color: Colors.black),
                Row(
                  children: [
                    normaltext(
                        text: widget.data['p_catogery'],
                        color: fontGrey,
                        siza: 16.0),
                    SizedBox(
                      width: MediaQueryu.getScreenWidth(context) * .01,
                    ),
                    normaltext(
                        text: widget.data['p_subcategory'],
                        color: fontGrey,
                        siza: 16.0),
                  ],
                ),
                SizedBox(
                  height: MediaQueryu.getScreenHeight(context) * .01,
                ),
                VxRating(
                  isSelectable: false,
                  value: double.parse(widget.data['p_rating']),
                  normalColor: white,
                  selectionColor: golden,
                  count: 5,
                  maxRating: 5,
                  size: MediaQueryu.getScreenHeight(context) * 0.04,
                  onRatingUpdate: (value) {},
                ),
                normaltext(text: widget.data['p_price'], color: Colors.black),
                SizedBox(
                  height: MediaQueryu.getScreenHeight(context) * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Color',
                          ),
                          SizedBox(
                            width: MediaQueryu.getScreenWidth(context) * 0.25,
                          ),
                          Row(
                            children: List.generate(
                              widget.data['p_colors'].length,
                              (index) => VxBox()
                                  .size(40.0, 40.0)
                                  .margin(EdgeInsets.symmetric(horizontal: 2))
                                  .roundedFull
                                  .color(Color(int.parse(widget.data['p_colors']
                                          [index]
                                      .toString())))

                                  //     .color(
                                  //     // Color(int.parse(
                                  //     // widget.data['p_colors'][index]))
                                  // )
                                  .make()
                                  .onTap(() {
                                // changecolorindex(index);
                              }),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQueryu.getScreenHeight(context) * 0.01,
                      ),
                      Row(
                        children: [
                          normaltext(text: 'quentity', color: Colors.black),
                          SizedBox(
                            width: MediaQueryu.getScreenWidth(context) * 0.24,
                          ),
                          normaltext(
                              text: widget.data["p_quantity"],
                              color: Colors.black),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(),
                SizedBox(
                  height: MediaQueryu.getScreenHeight(context) * 0.01,
                ),
                normaltext(text: 'description', color: Colors.black),
                SizedBox(
                  height: MediaQueryu.getScreenHeight(context) * 0.01,
                ),
                normaltext(
                    text: widget.data["p_description"], color: Colors.black),
              ],
            ),
          )
        ],
      ),
    );
  }
}
