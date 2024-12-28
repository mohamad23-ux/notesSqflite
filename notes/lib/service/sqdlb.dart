//this is my database

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class sqlDb {
  ///for not doing instance "i think you remember it  " we will make static databic member
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initalDb();
      return _db;
    } else {
      return _db;
    }
  }

  initalDb() async {
    String databasePath = await getDatabasesPath();
    //اول شي عملنا المسار وحددناه
    //هلق لازم نختار اسم الdb  : path + hisname
    String path = join(databasePath, 'notes.db');
    //creating Database
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 39, onUpgrade: _onUpgrade);

    return mydb;
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("ko its upgrade ");
  }

  //_onCreate this is the function to doing the Database
  //to creating tables : this method :  _onCreate
  void _onCreate(Database db, int version) async {
    //to creating more than table in the single project :

    //   Batch btch = db.batch();
    // btch.execute('''CREATE TABLE ''')
//await btch.commit() for not doing await and db.excute ...... alot of  times

    await db.execute('''
  CREATE TABLE "notes" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "title" TEXT NOT NULL,
    "note" TEXT NOT NULL,
    "kind" TEXT DEFAULT 'NOTHING'
  )
''');


//**tables of university */
    await db.execute('''
    CREATE TABLE IF NOT EXISTS "subjects" (
      "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      "day" TEXT NOT NULL,
      "subject" TEXT NOT NULL,
      "time" TEXT DEFAULT 'EMPTY'
    )
  ''');

  
    await db.execute('''
  CREATE TABLE iF NOT EXISTS "EXAMS" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "name" TEXT NOT NULL,
    "degree" INTEGER NOT NULL,
    "homeworkDegree" INTEGER NOT NULL
    
      
  )
''');


 //* these is tables for excersies and making Gym things  */
    await db.execute('''
    CREATE TABLE "myExercise" (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL   ,
       day TEXT NOT NULL
     
      
    )
  ''');
    await db.execute('''
    CREATE TABLE "exDetails" (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL   ,
      groupe TEXT NOT NULL,
      weight TEXT NOT NULL  ,
      exercise_id INTEGER NOT NULL,
      FOREIGN KEY (exercise_id) REFERENCES myExercise(id)
    )
  ''');
  }

  readData(String sql) async {
    Database? mydb = await db;
    //all those what i was writting for the nect line command :
    //هون بدي اخد الداتا لي رح ترجعلي من الداتا بيز تبعي واللي هي mydb
    List<Map> response = await mydb!.rawQuery(sql);

    return response;
  }
  //نفسها مع باقي الكرود

  insertData(String sql) async {
    Database? mydb = await db;
    //all those what i was writting for the nect line command :
    //هون بدي اخد الداتا لي رح ترجعلي من الداتا بيز تبعي واللي هي mydb
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    //all those what i was writting for the nect line command :
    //هون بدي اخد الداتا لي رح ترجعلي من الداتا بيز تبعي واللي هي mydb
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  DeleteData(String sql) async {
    Database? mydb = await db;
    //all those what i was writting for the nect line command :
    //هون بدي اخد الداتا لي رح ترجعلي من الداتا بيز تبعي واللي هي mydb
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  Future<int> deleteAllData() async {
    Database? mydb = await db; // تأكد من استدعاء قاعدة البيانات بشكل صحيح
    return await mydb!
        .delete('myExercise'); // تأكد من استخدام اسم الجدول الصحيح
  }
  deleteDeepData(String sql) async {
    Database? mydb = await db;
    //all those what i was writting for the nect line command :
    //هون بدي اخد الداتا لي رح ترجعلي من الداتا بيز تبعي واللي هي mydb
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  //for Subjects Table

  readSub(String sql) async {
    Database? mydb = await db;
    //all those what i was writting for the nect line command :
    //هون بدي اخد الداتا لي رح ترجعلي من الداتا بيز تبعي واللي هي mydb
    List<Map> response = await mydb!.rawQuery(sql);
    print("${response}");
    return response;
  }

  //نفسها مع باقي الكرود

  insertSub(String sql) async {
    Database? mydb = await db;
    //all those what i was writting for the nect line command :
    //هون بدي اخد الداتا لي رح ترجعلي من الداتا بيز تبعي واللي هي mydb
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateSub(String sql) async {
    Database? mydb = await db;
    //all those what i was writting for the nect line command :
    //هون بدي اخد الداتا لي رح ترجعلي من الداتا بيز تبعي واللي هي mydb
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  DeleteSub(String sql) async {
    Database? mydb = await db;
    //all those what i was writting for the nect line command :
    //هون بدي اخد الداتا لي رح ترجعلي من الداتا بيز تبعي واللي هي mydb
    int response = await mydb!.rawDelete(sql);
    return response;
  }
  
}
