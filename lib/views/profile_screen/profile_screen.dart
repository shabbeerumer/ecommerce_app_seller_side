import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_e_commerce_app_seller_side/const/const.dart';
import 'package:flutter_e_commerce_app_seller_side/controllers/auth_controller.dart';
import 'package:flutter_e_commerce_app_seller_side/views/profile_screen/edit_screen.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/texts.dart';
import 'package:flutter_e_commerce_app_seller_side/services/store_services.dart';
import '../../widgets/lodingindicator.dart';
import '../messages_screen/messages_screen.dart';
import '../shopsttings/shopsttings.dart';

class profile_screen extends StatefulWidget {
  const profile_screen({Key? key}) : super(key: key);

  @override
  State<profile_screen> createState() => _profile_screenState();
}

class _profile_screenState extends State<profile_screen> {
  DocumentSnapshot? snapshotdata;

  @override
  void initState() {
    super.initState();
    fetchProfileData(); // Function to fetch profile data
  }

  void fetchProfileData() async {
    QuerySnapshot snapshot = await storeservices.getproducts(user!.uid);
    if (snapshot.docs.isNotEmpty) {
      setState(() {
        snapshotdata = snapshot.docs[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: normaltext(
            text: 'setting',
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => edit_screen(
                                snapshotdata: snapshotdata,
                              )));
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                )),
            TextButton(
              onPressed: () {
                signoutmethod(context);
              },
              child: boldtext(
                text: 'logout',
              ),
            )
          ],
        ),
        body: FutureBuilder<QuerySnapshot>(
            future: storeservices.getproducts(user!.uid),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: lodingindicator(circlecolor: white));
              } else if (snapshot.hasError) {
                return Center(
                    child: normaltext(text: 'some things wants wrong'));
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                    child: normaltext(
                  text: 'No data available',
                ));
              } else {
                var data = snapshot.data!.docs[0];

                return Column(
                  children: [
                    ListTile(
                      title: normaltext(text: data['vender_name'].toString()),
                      subtitle: normaltext(text: data['email'].toString()),
                      leading: data['imageurl'] == ''
                          ? CircleAvatar(
                              radius: 40.0,
                              backgroundColor: white,
                              backgroundImage: AssetImage(
                                'assets/icons/product.jpg',
                              ),
                            )
                          : CircleAvatar(
                              radius: 40.0,
                              backgroundImage: NetworkImage(data['imageurl']),
                            ),
                      // CircleAvatar(
                      //   backgroundImage: AssetImage(
                      //     'assets/icons/product.jpg',
                      //   ),
                      //   radius: 40,
                      // ),
                    ),
                    Column(
                      children: List.generate(
                          prfilebuttonicon.length,
                          (index) => ListTile(
                                onTap: () {
                                  switch (index) {
                                    case 0:
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  shopsettings()));
                                      break;
                                    case 1:
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  messages_screen()));
                                      break;
                                  }
                                },
                                leading: Icon(prfilebuttonicon[index],
                                    color: Colors.white),
                                title:
                                    normaltext(text: prfilebuttontitle[index]),
                              )),
                    )
                  ],
                );
              }
            }));
  }
}
