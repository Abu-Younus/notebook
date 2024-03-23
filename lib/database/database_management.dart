import 'dart:io';
import 'package:notebook/models/notebook_model.dart';
import 'package:notebook/models/user_model.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  static const String userTable = 'user';
  static const String notebookTable = 'notebook';

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'notebook.db');
    return openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute(
          "CREATE TABLE $notebookTable (id INTEGER PRIMARY KEY AUTOINCREMENT,userid int,title TEXT,content TEXT,date TEXT)");
      db.execute(
          "CREATE TABLE $userTable (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,email TEXT,password TEXT)");
    });
  }

  Future<int> registerUser(UserModel user) async {
    Database db = await initDatabase();
    return db.insert(userTable, user.toMap());
  }

  Future<bool> isUserExist(String email) async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> userMapList =
        await db.rawQuery("SELECT * FROM $userTable WHERE email = '$email'");
    if (userMapList.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<UserModel> fetchUserById(int id) async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> userMapList =
        await db.rawQuery("SELECT * FROM $userTable WHERE id = '$id'");
    if (userMapList.isEmpty) {
      return UserModel();
    } else {
      Map<String, dynamic> userMap = userMapList[0];
      return UserModel(
          id: userMap['id'],
          email: userMap['email'],
          name: userMap['name'],
          password: userMap['password']);
    }
  }

  Future<UserModel> fetchUserByEmailAndPassword(
      String email, String password) async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> userMapList = await db.rawQuery(
        "SELECT * FROM $userTable WHERE email = '$email' AND password = '$password'");
    if (userMapList.isEmpty) {
      return UserModel();
    } else {
      Map<String, dynamic> userMap = userMapList[0];
      return UserModel(
          id: userMap['id'],
          email: userMap['email'],
          name: userMap['name'],
          password: userMap['password']);
    }
  }

  Future<int> insertNote(Notebook notebook) async {
    Database db = await initDatabase();
    return db.insert(notebookTable, notebook.toMap());
  }

  Future<List<Notebook>> fetchNoteList(int userId) async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> notebookMapList = await db
        .rawQuery("SELECT * FROM $notebookTable WHERE userid = '$userId'");
    return List.generate(
      notebookMapList.length,
          (index) {
        return Notebook(
          id: notebookMapList[index]['id'],
          title: notebookMapList[index]['title'],
          content: notebookMapList[index]['content'],
          date: notebookMapList[index]['date'],
        );
      },
    );
  }

  Future<int> deleteNote(int id) async {
    Database db = await initDatabase();
    return db.delete(notebookTable, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateNote(Notebook notebook) async {
    Database db = await initDatabase();
    return db.update(notebookTable, notebook.toMap(), where: 'id = ?', whereArgs: [notebook.id]);
  }
}
