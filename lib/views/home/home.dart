import 'package:flutter_e_commerce_app_seller_side/const/const.dart';
import 'package:flutter_e_commerce_app_seller_side/views/dashbord_screen/dashbord_screen.dart';
import 'package:flutter_e_commerce_app_seller_side/views/order_screen/order_screen.dart';
import 'package:flutter_e_commerce_app_seller_side/views/product_screen/product_screen.dart';
import 'package:flutter_e_commerce_app_seller_side/views/profile_screen/profile_screen.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var bottomitem = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'dashbord'),
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/products.png',
            color: darkGrey,
            width: 24,
          ),
          label: 'products'),
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/orders.png',
            color: darkGrey,
            width: 24,
          ),
          label: 'orders'),
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/general_setting.png',
            color: darkGrey,
            width: 24,
          ),
          label: 'setting'),
    ];
    var bottombody = [
      const dashbord_screen(),
      const product_screen(),
      const order_screen(),
      const profile_screen(),
    ];
    return Scaffold(
      body: bottombody[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: purpleColor,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: bottomitem,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
