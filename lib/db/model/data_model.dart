class StudentModel {
  int? id;
  final String name;
  final String age;
  final String phone;
  final String location;
  final String image;

  StudentModel(
      {required this.name,
      required this.age,
      required this.phone,
      required this.location,
      required this.image,
      this.id});

  static StudentModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final name = map['name'] as String;
    final age = map['age'] as String;
    final phone = map['phone'] as String;
    final location = map['location'] as String;
    final image = map['image'] as String;

    return StudentModel(
        id: id,
        name: name,
        age: age,
        phone: phone,
        location: location,
        image: image);
  }
}
