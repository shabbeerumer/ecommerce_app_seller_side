import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_e_commerce_app_seller_side/const/const.dart';
import 'package:flutter_e_commerce_app_seller_side/views/messages_screen/chat_screen.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/lodingindicator.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/texts.dart';
import 'package:flutter_e_commerce_app_seller_side/services/store_services.dart';
import 'package:intl/intl.dart' as intl;

class messages_screen extends StatefulWidget {
  const messages_screen({Key? key}) : super(key: key);

  @override
  State<messages_screen> createState() => _messages_screenState();
}

class _messages_screenState extends State<messages_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: normaltext(text: 'Messages', color: Colors.black),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: storeservices.getmessages(user!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: lodingindicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Some Things Wants Wrong'));
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(data.length, (index) {
                      var t = data[index]['created_on'] == null
                          ? DateTime.now()
                          : data[index]['created_on'].toDate();
                      var time = intl.DateFormat('h:mma').format(t);

                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => chat_screen()));
                        },
                        leading: CircleAvatar(
                          backgroundColor: purpleColor,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                        title: boldtext(
                            text: data[index]['sender_name'], color: fontGrey),
                        subtitle: normaltext(
                            text: data[index]['lastmsg'], color: darkGrey),
                        trailing: normaltext(text: time, color: darkGrey),
                      );
                    }),
                  ),
                ),
              );
            } else {
              return Center(
                  child: Text(
                'No message found!',
                style: TextStyle(fontSize: 20),
              ));
            }
          }),
    );
  }
}
