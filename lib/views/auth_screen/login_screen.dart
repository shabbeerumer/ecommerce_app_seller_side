import 'package:flutter_e_commerce_app_seller_side/const/const.dart';
import 'package:flutter_e_commerce_app_seller_side/views/home/home.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/mediaquery.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/ourbutton.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/texts.dart';

import '../../controllers/auth_controller.dart';
import '../../widgets/lodingindicator.dart';

class login_screen extends StatefulWidget {
  const login_screen({Key? key}) : super(key: key);

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * .03,
              ),
              normaltext(text: 'Hi,Welcome to', siza: 20.0),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * .02,
              ),
              Row(children: [
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white)),
                    child: Image.asset(
                      'assets/icons/logo.png',
                      height: 70,
                      width: 70,
                    )),
                SizedBox(
                  width: MediaQueryu.getScreenWidth(context) * .02,
                ),
                boldtext(text: 'ECommerce Seller App', siza: 20.0),
              ]),
              SizedBox(
                height: MediaQueryu.getScreenHeight(context) * .02,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            border: InputBorder.none,
                            hintText: 'eg vender@gmail.com'),
                        controller: emailcontroller,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.lock),
                            hintText: '* * * * *'),
                        controller: passwordcontroller,
                      ),
                      SizedBox(
                        height: MediaQueryu.getScreenHeight(context) * .02,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {},
                            child: normaltext(
                                text: 'Forget Password?', color: Colors.black)),
                      ),
                      isloading
                          ? lodingindicator()
                          : ourbutton(
                              text: 'Login',
                              context: context,
                              onpress: () async {
                                setState(() {
                                  isloading = true;
                                });
                                try {
                                  await loginmethod(
                                      emailcontroller.text.toString(),
                                      passwordcontroller.text.toString(),
                                      context);
                                } catch (e) {
                                  VxToast.show(context,
                                      msg: 'Something went wrong');
                                } finally {
                                  setState(() {
                                    isloading = false;
                                  });
                                }
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => home()));
                              }),
                      SizedBox(
                        height: MediaQueryu.getScreenHeight(context) * .02,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
