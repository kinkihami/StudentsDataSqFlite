import 'package:flutter/material.dart';
import 'package:new_project_sqflite/db/model/data_model.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

late Database _db;

Future<void> initializeDatabase() async {
  _db = await openDatabase(
    'student.dp',
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE student(id INTEGER PRIMARY KEY,name TEXT,age TEXT,phone TEXT,location TEXT,image TEXT)');
    },
  );
}

Future<void> getAllStudents() async {
  final _values = await _db.rawQuery('SELECT * FROM student');
  print(_values);
  studentListNotifier.value.clear();
  _values.forEach((map) {
    final student = StudentModel.fromMap(map);
    studentListNotifier.value.add(student);
  });
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  studentListNotifier.notifyListeners();
}

Future<void> addStudent(StudentModel value) async {
  await _db.rawInsert(
      'INSERT INTO student (name,age,phone,location,image) VALUES(?,?,?,?,?)',
      [value.name, value.age, value.phone, value.location, value.image]);
  getAllStudents();
}

Future<void> deleteStudent(int id) async {
  await _db.delete('student', where: 'id=?', whereArgs: [id]);
  getAllStudents();
}

Future<void> editStudent(int id, String name, String age, String phone,
    String location, String image) async {
  final data = {
    'name': name,
    'age': age,
    'phone': phone,
    'location': location,
    'image': image,
  };
  await _db.update('student', data, where: 'id=?', whereArgs: [id]);
  getAllStudents();
}
