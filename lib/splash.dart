import 'package:flutter/material.dart';
import 'package:new_project_sqflite/home.dart';
import 'package:new_project_sqflite/login.dart';
import 'package:new_project_sqflite/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    Checklogged();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF05161A),
      body: Center(
        child: Image.asset('assets/image/icons8-dailyart-150.png'),
      ),
    );
  }

  Future<void> home() async {
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx1) => ScreenHome()));
  }

  Future<void> login() async {
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx1) => ScreenLogin()));
  }

  Future<void> Checklogged() async {
    final shdprfnc = await SharedPreferences.getInstance();
    final userloggedin = shdprfnc.getBool(userLogged);
    if (userloggedin == null || userloggedin == false) {
      login();
    } else {
      home();
    }
  }
}
