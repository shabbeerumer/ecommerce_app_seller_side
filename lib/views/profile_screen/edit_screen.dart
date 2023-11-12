import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_e_commerce_app_seller_side/const/const.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/mediaquery.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/textformfield.dart';
import 'package:flutter_e_commerce_app_seller_side/widgets/texts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class edit_screen extends StatefulWidget {
  var snapshotdata;
  edit_screen({Key? key, required this.snapshotdata}) : super(key: key);

  @override
  State<edit_screen> createState() => _edit_screenState();
}

class _edit_screenState extends State<edit_screen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController oldpasswordcontroller = TextEditingController();
  TextEditingController newpasswordcontroller = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namecontroller.text = widget.snapshotdata['vender_name'].toString();
    print(namecontroller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: normaltext(
          text: 'Edit Profile',
        ),
        actions: [
          TextButton(
            onPressed: () async {
              var imageUrl = await _uploadFile();
              await updateProfile(
                  namecontroller.text,
                  imageUrl,
                  oldpasswordcontroller.text,
                  newpasswordcontroller.text,
                  widget.snapshotdata['email']);
            },
            child: boldtext(
              text: 'save',
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: 150,
              width: 150,
              child: ClipOval(
                child: (widget.snapshotdata['imageurl'] == '' &&
                        (profileimagepath == null ||
                            profileimagepath!.path.isEmpty))
                    ? Image.asset(
                        'assets/icons/product.jpg',
                        fit: BoxFit.cover,
                      )
                    : (widget.snapshotdata['imageurl'] != '' &&
                            (profileimagepath == null ||
                                profileimagepath!.path.isEmpty))
                        ? Image.network(
                            widget.snapshotdata['imageurl'],
                            fit: BoxFit.cover,
                          )
                        : (profileimagepath != null &&
                                profileimagepath!.path.isEmpty)
                            ? Image.file(
                                File(profileimagepath!.path),
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/icons/product.jpg',
                                fit: BoxFit.cover,
                              ),
              ),
            ),

            // Container(
            //   clipBehavior: Clip.antiAlias,
            //   decoration:
            //       BoxDecoration(borderRadius: BorderRadius.circular(50)),
            //   child: Image.asset(
            //     'assets/icons/product.jpg',
            //     height: 100,
            //     width: 100,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            SizedBox(
              height: MediaQueryu.getScreenHeight(context) * .01,
            ),
            ElevatedButton(
                onPressed: () {
                  change_image(context);
                },
                child: normaltext(text: 'change image', color: fontGrey)),
            SizedBox(
              height: MediaQueryu.getScreenHeight(context) * .01,
            ),
            Divider(),
            SizedBox(
              height: MediaQueryu.getScreenHeight(context) * .02,
            ),
            textformfield(
              controller: namecontroller,
              lable: 'name',
              hint: 'seller',
            ),
            SizedBox(
              height: MediaQueryu.getScreenHeight(context) * .02,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: boldtext(text: 'Change Password')),
            SizedBox(
              height: MediaQueryu.getScreenHeight(context) * .02,
            ),
            textformfield(
                lable: 'password',
                hint: '* * * * *',
                controller: oldpasswordcontroller),
            SizedBox(
              height: MediaQueryu.getScreenHeight(context) * .02,
            ),
            textformfield(
                lable: 'conformpassword',
                hint: '* * * * *',
                controller: newpasswordcontroller),
          ],
        ),
      ),
    );
  }

  File? profileimagepath;
  Future change_image(BuildContext context) async {
    try {
      final pickedFile = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 70);

      if (pickedFile != null) {
        setState(() {
          profileimagepath = File(pickedFile.path);
        });
      } else {}
    } catch (error) {
      VxToast.show(context, msg: 'Something went wrong');
    }
  }

  Future<String?> _uploadFile() async {
    if (profileimagepath == null) {
      return '';
    }

    FirebaseStorage _storage = FirebaseStorage.instance;
    Reference storageRef =
        _storage.ref().child('images/${auth.currentUser!.uid.toString()}.jpg');
    UploadTask uploadTask = storageRef.putFile(profileimagepath!.absolute);
    TaskSnapshot downloadUrl = await uploadTask;
    final url = await downloadUrl.ref.getDownloadURL();
    return url; // Return the download URL
  }

  Future<void> updateProfile(String name, imageUrl, String oldPassword,
      String newPassword, email) async {
    try {
      // Verify user's existing password
      if (oldPassword.isNotEmpty) {
        final cred =
            EmailAuthProvider.credential(email: email, password: oldPassword);
        await auth.currentUser!.reauthenticateWithCredential(cred);

        // User wants to change the password
        if (newPassword.isNotEmpty) {
          await auth.currentUser!.updatePassword(newPassword);
        } else {}
      } else {}

      // Update user profile data in Firestore
      await firestore.collection('venders').doc(user!.uid).set(
        {'vender_name': name, 'password': newPassword, 'imageurl': imageUrl},
      );

      VxToast.show(context, msg: 'Updated');
    } catch (e) {
      VxToast.show(context, msg: 'Something went wrong');
      print('Error updating profile: $e');
    }
  }
}
