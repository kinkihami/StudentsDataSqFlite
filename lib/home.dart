import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_project_sqflite/add.dart';
import 'package:new_project_sqflite/db/functions/data_funtion.dart';
import 'package:new_project_sqflite/db/model/data_model.dart';
import 'package:new_project_sqflite/details.dart';
import 'package:new_project_sqflite/edit.dart';
import 'package:new_project_sqflite/login.dart';
import 'package:new_project_sqflite/search.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
        backgroundColor: Color(0xFF072E33),
        appBar: AppBar(
          backgroundColor: Color(0xFF05161A),
          leadingWidth: 85,
          leading: TextButton(
              onPressed: () {
                signout(context);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.exit_to_app,
                    color: Color(0xFF0C7078),
                  ),
                  Text(
                    'Logout',
                    style: TextStyle(color: Color(0xFF0C7078)),
                  ),
                ],
              )),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => ScreenSearch()));
                },
                icon: Icon(
                  Icons.search,
                  color: Color(0xFF0C7078),
                ))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: studentListNotifier,
                builder: (BuildContext ctx, List<StudentModel> studentList,
                    Widget? child) {
                  return ListView.builder(
                      itemBuilder: (ctx, index) {
                        final data = studentList[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 5,
                            right: 5,
                          ),
                          child: Container(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                color: Color(0xFF05161A),
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (ctx) => ScreenDetails(
                                              name: data.name,
                                              age: data.age,
                                              phone: data.phone,
                                              location: data.location,
                                              image: data.image,
                                            ))),
                                leading: CircleAvatar(
                                  backgroundImage: FileImage(File(data.image)),
                                ),
                                title: Text(
                                  'Name: ${data.name}',
                                  style: TextStyle(color: Color(0xFF0C7078)),
                                ),
                                // subtitle: Text(
                                //   'Age: ${data.age}',
                                //   style: TextStyle(color: Color(0xFF0C7078)),
                                // ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (ctx) => ScreenEdit(
                                                      student: data)));
                                        },
                                        icon: Icon(Icons.edit,
                                            color: Color(0xFF0C7078))),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                                  backgroundColor:
                                                      Color(0xFF05161A),
                                                  title: Text(
                                                    'Are You Sure?',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF0C7078)),
                                                  ),
                                                  actions: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        ElevatedButton(
                                                            style: ButtonStyle(
                                                                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20))),
                                                                backgroundColor:
                                                                    MaterialStatePropertyAll(
                                                                        Color(
                                                                            0xFF072E33))),
                                                            onPressed: () {
                                                              deleteStudent(
                                                                  data.id!);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                  duration:
                                                                      Duration(
                                                                          seconds:
                                                                              1),
                                                                  behavior:
                                                                      SnackBarBehavior
                                                                          .floating,
                                                                  margin: EdgeInsets
                                                                      .all(10),
                                                                  backgroundColor:
                                                                      Colors.redAccent[
                                                                          700],
                                                                  content: Text(
                                                                      'Successfully Deleted!!!!')));
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  'Yes',
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF0C7078)),
                                                                ),
                                                                Icon(
                                                                  Icons.done,
                                                                  color: Color(
                                                                      0xFF0C7078),
                                                                )
                                                              ],
                                                            )),
                                                        ElevatedButton(
                                                            style: ButtonStyle(
                                                                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20))),
                                                                backgroundColor:
                                                                    MaterialStatePropertyAll(
                                                                        Color(
                                                                            0xFF072E33))),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  'No',
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF0C7078)),
                                                                ),
                                                                Icon(
                                                                  Icons.clear,
                                                                  color: Color(
                                                                      0xFF0C7078),
                                                                )
                                                              ],
                                                            ))
                                                      ],
                                                    )
                                                  ],
                                                ));
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        // color: Color(0xFF0C7078),
                                        color: Colors.redAccent[700],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        );
                      },
                      itemCount: studentList.length);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                      fixedSize: MaterialStatePropertyAll(Size(170, 50)),
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xFF05161A))),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) {
                          return ScreenAdd();
                        },
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_rounded,
                        color: Color(0xFF0C7078),
                      ),
                      Text(
                        'Add New Student',
                        style: TextStyle(color: Color(0xFF0C7078)),
                      ),
                    ],
                  )),
            )
          ],
        ));
  }

  void signout(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              backgroundColor: Color(0xFF05161A),
              title: Text(
                'Do You want to Logout?',
                style: TextStyle(color: Color(0xFF0C7078)),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            backgroundColor:
                                MaterialStatePropertyAll(Color(0xFF072E33))),
                        onPressed: () {
                          out(context);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.done,
                              color: Color(0xFF0C7078),
                            ),
                            Text(
                              'Yes',
                              style: TextStyle(color: Color(0xFF0C7078)),
                            )
                          ],
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            backgroundColor:
                                MaterialStatePropertyAll(Color(0xFF072E33))),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.clear_outlined,
                              color: Color(0xFF0C7078),
                            ),
                            Text(
                              'No',
                              style: TextStyle(color: Color(0xFF0C7078)),
                            )
                          ],
                        ))
                  ],
                )
              ],
            ));
  }
}

Future<void> out(context) async {
  final shrdprfrnce = await SharedPreferences.getInstance();
  await shrdprfrnce.clear();
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: ((context) => ScreenLogin())),
      (route) => false);
}
