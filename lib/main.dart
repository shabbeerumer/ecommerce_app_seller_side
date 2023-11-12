import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_e_commerce_app_seller_side/const/const.dart';
import 'package:flutter_e_commerce_app_seller_side/firebase_options.dart';
import 'package:flutter_e_commerce_app_seller_side/views/auth_screen/login_screen.dart';
import 'package:flutter_e_commerce_app_seller_side/views/home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ECommerce App Seller Side',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: user != null ? home() : login_screen());
  }
}
