import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_project_sqflite/db/functions/data_funtion.dart';
import 'package:new_project_sqflite/db/model/data_model.dart';

final name = TextEditingController();
final age = TextEditingController();
final phone = TextEditingController();
final location = TextEditingController();

File? image1;
String? image;
final _formkey = GlobalKey<FormState>();

class ScreenAdd extends StatefulWidget {
  const ScreenAdd({
    super.key,
  });

  @override
  State<ScreenAdd> createState() => _ScreenAddState();
}

class _ScreenAddState extends State<ScreenAdd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF072E33),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: image1 != null
                            ? FileImage(image1!)
                            : AssetImage('assets/image/Unknown_person.jpg')
                                as ImageProvider,
                        radius: 40,
                      ),
                      Positioned(
                        child: CircleAvatar(
                          radius: 17,
                          backgroundColor: Color(0xFF072E33),
                          child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (ctx) {
                                      return Container(
                                        width: double.infinity,
                                        height: 130,
                                        color: Color(0xFF05161A),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Text(
                                                'Choose Image from...',
                                                style: TextStyle(
                                                    color: Color(0xFF0C7078),
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                Color(
                                                                    0xFF072E33))),
                                                    onPressed: () {
                                                      fromGallery();
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'From Gallery ',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF0C7078)),
                                                        ),
                                                        Icon(
                                                          Icons.image,
                                                          color:
                                                              Color(0xFF0C7078),
                                                        ),
                                                      ],
                                                    )),
                                                ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                Color(
                                                                    0xFF072E33))),
                                                    onPressed: () {
                                                      fromCamera();
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'From Camera',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF0C7078)),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .camera_alt_outlined,
                                                          color:
                                                              Color(0xFF0C7078),
                                                        ),
                                                      ],
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.camera_alt_rounded,
                                color: Color(0xFF0C7078),
                                size: 17,
                              )),
                        ),
                        top: 45,
                        left: 55,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Your Name';
                      } else {
                        return null;
                      }
                    },
                    controller: name,
                    cursorColor: Color(0xFF0C7078),
                    style: TextStyle(color: Color(0xFF0C7078)),
                    decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xFF0C7078),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF0C7078))),
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Color(0xFF0C7078)),
                        filled: true,
                        fillColor: Color(0xFF05161A)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Your Age';
                      } else {
                        return null;
                      }
                    },
                    controller: age,
                    cursorColor: Color(0xFF0C7078),
                    style: TextStyle(color: Color(0xFF0C7078)),
                    decoration: InputDecoration(
                        counterText: "",
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        prefixIcon: Icon(
                          Icons.timeline,
                          color: Color(0xFF0C7078),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF0C7078))),
                        labelText: 'Age',
                        labelStyle: TextStyle(color: Color(0xFF0C7078)),
                        filled: true,
                        fillColor: Color(0xFF05161A)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Your Phone number';
                      } else if (value.length != 10) {
                        return 'Invalid phone number';
                      } else {
                        return null;
                      }
                    },
                    controller: phone,
                    cursorColor: Color(0xFF0C7078),
                    style: TextStyle(color: Color(0xFF0C7078)),
                    decoration: InputDecoration(
                        counterText: "",
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Color(0xFF0C7078),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF0C7078))),
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(color: Color(0xFF0C7078)),
                        filled: true,
                        fillColor: Color(0xFF05161A)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Your Location';
                      } else {
                        return null;
                      }
                    },
                    controller: location,
                    cursorColor: Color(0xFF0C7078),
                    style: TextStyle(color: Color(0xFF0C7078)),
                    decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        prefixIcon: Icon(
                          Icons.pin_drop_outlined,
                          color: Color(0xFF0C7078),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF0C7078))),
                        labelText: 'Location',
                        labelStyle: TextStyle(color: Color(0xFF0C7078)),
                        filled: true,
                        fillColor: Color(0xFF05161A)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(Size(100, 50)),
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xFF05161A))),
                      onPressed: () {
                        getdata(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.done,
                            color: Color(0xFF0C7078),
                          ),
                          Text(
                            'Done',
                            style: TextStyle(color: Color(0xFF0C7078)),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getdata(context) async {
    final _name = name.text.trim();
    final _age = age.text.trim();
    final _phone = phone.text.trim();
    final _location = location.text.trim();

    print(image1);
    if (_formkey.currentState!.validate() && image1 != null) {
      final student = StudentModel(
          name: _name,
          age: _age,
          phone: _phone,
          location: _location,
          image: image!);

      addStudent(student);
      setState(() {
        image1 = null;
      });
      name.clear();
      age.clear();
      phone.clear();
      location.clear();
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent[700],
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
          content: Text(
            'Add Profile Image!!!',
          ),
        ),
      );
    }
  }

  Future<void> fromGallery() async {
    Navigator.of(context).pop();
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() {
        image1 = File(img.path);
        image = image1!.path;
      });
    }
  }

  Future<void> fromCamera() async {
    Navigator.of(context).pop();
    final img = await ImagePicker().pickImage(source: ImageSource.camera);
    if (img != null) {
      setState(() {
        image1 = File(img.path);
        image = image1!.path;
      });
    }
  }
}
