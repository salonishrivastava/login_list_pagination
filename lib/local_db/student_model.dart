class Student{
  String name;
  String age;
  int? id;
  Student({this.id,required this.name,required this.age});
Map<String ,dynamic> toMap(){
  return {
    "id": id, "name": name, "age": age
  };
}

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      age: map['age'],

    );
  }

}