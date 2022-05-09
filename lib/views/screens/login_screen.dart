import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vostok_clone/constants.dart';
import 'package:vostok_clone/views/widgets/text_input_field.dart';
import 'package:http/http.dart' as http;

import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    late List data;

    Future<String> getData(String username, String password) async {

      final username = _usernameController.text;
      final password = _passwordController.text;
      //login
      Map userData = {'username': username, "password": password};
      var userDataJson = json.encode(userData);
      var resp = await http.post(Uri.http("192.168.1.111:5000", "/auth/login"),
          headers: {
            "Accept": "application/json",
          },
          body: userDataJson);
      if(resp.statusCode == 200){
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => MainScreen()));
      }else{
        print('Error');
      }

      var respTokenDict = json.decode(resp.body);
      var respToken = respTokenDict["access_token"];

      //example how to use token
      var response = await http
          .get(Uri.http("192.168.1.111:5000", "/teacherSubject"), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer " + respToken
      });
      print(json.decode(response.body));
      return 'Success!';
    }
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'App',
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.green,
                  fontWeight: FontWeight.w900),
            ),
            const Text(
              'Авторизация',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _usernameController,
                labelText: 'Логин',
                icon: Icons.login,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _passwordController,
                labelText: 'Пароль',
                icon: Icons.lock,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: InkWell(
                onTap: () {
                  getData(_usernameController.text, _passwordController.text);
                },
                child: const Center(
                  child: Text(
                    'Войти',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: [
//                const Text(
//                  'У вас нет аккаута ?',
//                  style: TextStyle(
//                    fontSize: 20,
//                  ),
//                ),
//                InkWell(
//                  onTap: () {
//                    print('navigating user');
//                  },
//                  child: Text(
//                    ' Регистрация',
//                    style: TextStyle(fontSize: 20, color: Colors.green),
//                  ),
//                ),
//              ],
//            ),
          ],
        ),
      ),
    );
  }
}
