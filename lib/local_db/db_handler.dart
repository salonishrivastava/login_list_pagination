
import 'package:loginapi/local_db/student_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DbHandler{
static  Database? db;

  Future<Database> dbHelper() async {
    if(db != null){
      print(">>>>>>>0");
      return db!;
    }else{
      print(">>>>>>>1");
      db=await _initDb();
      return db!;
    }
    
  }


  Future<Database> _initDb() async {
    print(">>>>>>>2");
    final path = await getDatabasesPath();
  final  pathDb=join(path,"student.db");
 return  await openDatabase(
   pathDb,
   version: 2,
   onCreate: (db, version) async {
    await db.execute(
      '''
      CREATE TABLE student (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      age TEXT )
      '''
    );
  },);
  }

Future<void> printAllTables() async {


  // Query to get all table names
  final List<Map<String, dynamic>> tables = await db!.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table';"
  );

  print("📌 Tables in DB:");
  for (var table in tables) {
    print(table["name"]);
  }
}

  Future<void> insertData(Student std) async {
  await  db!.insert("student", std.toMap());
  }

  Future<List<Student>> fetchListDB() async {
    printAllTables();
    List<Map<String, dynamic>> list=  await  db!.query("student");

    return list.map((map){
      return Student.fromMap(map);
    }).toList();
  }



}