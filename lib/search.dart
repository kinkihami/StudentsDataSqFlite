import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_project_sqflite/db/functions/data_funtion.dart';
import 'package:new_project_sqflite/db/model/data_model.dart';
import 'package:new_project_sqflite/details.dart';

final search = TextEditingController();

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  List<StudentModel> founded = [];
  List<StudentModel> student = List.from(studentListNotifier.value);

  @override
  void initState() {
    founded = student;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF072E33),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          search.clear();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFF0C7078),
                          size: 20,
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextField(
                          style: TextStyle(color: Color(0xFF0C7078), height: 1),
                          cursorColor: Color(0xFF0C7078),
                          controller: search,
                          onChanged: (value) => searchedList(value),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none),
                              suffixIcon: search.text.length != 0
                                  ? IconButton(
                                      onPressed: () {
                                        search.clear();
                                        setState(() {
                                          founded = student;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.cancel,
                                        color: Color(0xFF0C7078),
                                      ))
                                  : null,
                              hintText: 'Search',
                              fillColor: Color(0xFF05161A),
                              filled: true,
                              hintStyle: TextStyle(color: Color(0xFF0C7078))),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                founded.length == 0
                    ? Expanded(
                        child: Center(
                          child: Text(
                            'No result found',
                            style: TextStyle(
                                color: Color(0xFF0C7078), fontSize: 20),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemBuilder: (ctx, index) {
                              final data = founded[index];
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
                                      backgroundImage:
                                          FileImage(File(data.image)),
                                    ),
                                    title: Text(
                                      'Name: ${data.name}',
                                      style:
                                          TextStyle(color: Color(0xFF0C7078)),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: founded.length),
                      ),
              ],
            ),
          ),
        ));
  }

  void searchedList(String value) {
    setState(() {
      founded = student
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }
}
