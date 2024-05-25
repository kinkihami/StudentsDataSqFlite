import 'dart:io';

import 'package:flutter/material.dart';

class ScreenDetails extends StatelessWidget {
  final name;
  final age;
  final phone;
  final location;
  final image;

  const ScreenDetails(
      {super.key,
      required this.name,
      required this.age,
      required this.phone,
      required this.location,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF05161A),
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.clear,
                    color: Color(0xFF0C7078),
                  )),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundImage: FileImage(File(image)),
                    radius: 50,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Name: $name',
                    style: TextStyle(color: Color(0xFF0C7078), fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Age: $age',
                    style: TextStyle(color: Color(0xFF0C7078), fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Phone: +91 $phone',
                    style: TextStyle(color: Color(0xFF0C7078), fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Location: $location',
                    style: TextStyle(color: Color(0xFF0C7078), fontSize: 20),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
