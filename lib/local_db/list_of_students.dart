import 'package:flutter/material.dart';
import 'package:loginapi/local_db/student_model.dart';

class ListOfStudents extends StatefulWidget {
  const ListOfStudents({super.key});

  @override
  State<ListOfStudents> createState() => _ListOfStudentsState();
}

class _ListOfStudentsState extends State<ListOfStudents> {
  List<Student> listOfStudents=[Student(id: 1,name: "saloni",age: "28")];

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          print("$value");
          if(value == 0){
            listOfStudents.add(Student(id: 2, name: "saloni2", age: "4"));
          }else{
            if(listOfStudents.isNotEmpty){
listOfStudents.removeLast();}
          }
          setState(() {

          });
        },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.add),label: "Add"),
            BottomNavigationBarItem(icon: Icon(Icons.delete),label: "remove")]),
      body: ListView.builder(
        itemCount:  listOfStudents.length,
      itemBuilder: (context, index) {
      return Container(
      height: 65,
          color: Colors.yellow,margin:EdgeInsets.all(4),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(listOfStudents[index].id.toString()),
              Text(listOfStudents[index].name),
              Text(listOfStudents[index].age),
            ],
          ));
    },),));
  }
}
