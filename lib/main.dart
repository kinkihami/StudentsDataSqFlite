import 'package:flutter/material.dart';
import 'package:new_project_sqflite/db/functions/data_funtion.dart';
import 'package:new_project_sqflite/splash.dart';

const userLogged = 'UserLogged';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenSplash(),
      theme: ThemeData(primarySwatch: Colors.yellow),
    );
  }
}
