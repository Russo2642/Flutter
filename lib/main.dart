import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:vostok_clone/constants.dart';
import 'package:vostok_clone/views/screens/login_screen.dart';
import 'package:vostok_clone/views/screens/main_screen.dart';
import 'package:vostok_clone/views/screens/signup_screen.dart';
import 'controllers/auth_conroller.dart';


void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => {
    Get.put(AuthController())
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: LoginScreen(),
    );
  }
}


//
//import 'dart:async';
//import 'dart:convert';
//
//import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//
//void main() {
//  runApp(const MaterialApp(
//    home: HomePage(),
//  ));
//}
//
//class HomePage extends StatefulWidget {
//  const HomePage({Key? key}) : super(key: key);
//
//  @override
//  HomePageState createState() => new HomePageState();
//}
//
//class HomePageState extends State<HomePage> {
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Center(
//        child: ElevatedButton(
//          child: const Text("Get data"),
//          onPressed: (){},
//        ),
//      ),
//    );
//  }
//}