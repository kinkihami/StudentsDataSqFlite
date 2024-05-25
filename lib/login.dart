import 'package:flutter/material.dart';
import 'package:new_project_sqflite/home.dart';
import 'package:new_project_sqflite/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenLogin extends StatelessWidget {
  final username = TextEditingController();
  final password = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF05161A),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formkey,
          child: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Color(0xFF072E33),
                    child: Icon(
                      Icons.person,
                      color: Color(0xFF0C7078),
                      size: 40,
                    ),
                  ),
                  Text(
                    'User Login',
                    style: TextStyle(color: Color(0xFF0C7078), fontSize: 25),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    style: TextStyle(color: Color(0xFF0C7078)),
                    cursorColor: Color(0xFF0C7078),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Username';
                      } else if (value != 'admin') {
                        return 'Enter correct Username';
                      } else {
                        return null;
                      }
                    },
                    controller: username,
                    decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF0C7075)),
                          borderRadius: BorderRadius.circular(20)),
                      filled: true,
                      fillColor: Color(0xFF072E33),
                      hintText: 'Username',
                      hintStyle: TextStyle(color: Color(0xFF0C7075)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF072E33)),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(color: Color(0xFF0C7075)),
                    cursorColor: Color(0xFF0C7078),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Password';
                      } else if (value != '123') {
                        return 'Enter correct password';
                      } else {
                        return null;
                      }
                    },
                    controller: password,
                    decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF0C7075)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Color(0xFF072E33),
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Color(0xFF0C7078)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF072E33)),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          fixedSize: MaterialStatePropertyAll(Size(100, 50)),
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xFF072E33))),
                      onPressed: () {
                        _formkey.currentState!.validate();
                        check(context);
                      },
                      child: Text(
                        'Login',
                        style:
                            TextStyle(color: Color(0xFF0C7075), fontSize: 15),
                      ))
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  void check(BuildContext context) async {
    final _username = username.text;
    final _password = password.text;
    if (_username == 'admin' && _password == '123') {
      final shrdprfrnce = await SharedPreferences.getInstance();
      await shrdprfrnce.setBool(userLogged, true);

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => ScreenHome()));
    }
  }
}
