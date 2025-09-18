import 'package:flutter/material.dart';
import 'package:loginapi/local_db/db_handler.dart';
import 'package:loginapi/local_db/student_model.dart';

class ListOfStudents extends StatefulWidget {
  const ListOfStudents({super.key});

  @override
  State<ListOfStudents> createState() => _ListOfStudentsState();
}

class _ListOfStudentsState extends State<ListOfStudents> {
  List<Student> listOfStudents=[];

  Future<void> init() async {
   await DbHandler().dbHelper();
   fetchList();
  }

  fetchList() async {
    listOfStudents= await DbHandler().fetchListDB();
    setState(() {

    });
  }

  addToList(String name, String age) async {
    await DbHandler().insertData(Student(name: name, age: age));
    fetchList();
  }

  dialogShowForAdd(){
    TextEditingController nameEditingController= TextEditingController();
    TextEditingController ageEditingController= TextEditingController();
    showModalBottomSheet(
      context: context,
     isScrollControlled: true, // important
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 12,),
                Text("ADD new sudent here"),
                SizedBox(height: 12,),
                TextField(controller: nameEditingController,
                  decoration: InputDecoration( hintText: "name enter here"),),
                TextField(controller: ageEditingController,
                    decoration :InputDecoration(hintText: "age here")),
                SizedBox(height: 12,),
                ElevatedButton(
                  onPressed: () {
                    addToList(nameEditingController.text,ageEditingController.text);
                    Navigator.pop(context);
                  },
                  child: Text("ADD"),
                ),
                SizedBox(height: 52,),
              ],
            ),
          ),
        );
      },
    );


  }

@override
  void initState() {
  init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          print("$value");
          if(value == 0){
            dialogShowForAdd();


          }else{
            if(listOfStudents.isNotEmpty){
             listOfStudents.removeLast();
            }
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
