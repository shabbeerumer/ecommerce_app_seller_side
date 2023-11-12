import 'package:flutter_e_commerce_app_seller_side/const/const.dart';
import 'package:flutter_e_commerce_app_seller_side/views/messages_screen/components/sender_bubble.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/mediaquery.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/textformfield.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/texts.dart';

class chat_screen extends StatefulWidget {
  const chat_screen({Key? key}) : super(key: key);

  @override
  State<chat_screen> createState() => _chat_screenState();
}

class _chat_screenState extends State<chat_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: normaltext(text: 'Chats', color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return sender_babble();
                    })),
            SizedBox(
              height: MediaQueryu.getScreenHeight(context) * .01,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Enter Message...',
                        hintStyle: TextStyle(color: darkGrey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: purpleColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: purpleColor),
                        )),
                  ),
                ),
                Icon(
                  Icons.send,
                  color: purpleColor,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
