import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smarttaskapp/models/task_model.dart';
import 'package:sqflite/sqflite.dart';

import '../constants.dart';
class DBHelper{

   DBHelper._();
  static final DBHelper _db=  DBHelper._();
  factory DBHelper(){
    return _db;
  }

    Database? _database;



   Future<Database> get db async{
    if(_database!=null)return _database!;
    _database=await initDB();
    return _database!;

//    if(_database!=null){
//      return _database!;
//    }else{
//      _database=await initDB();
//      return _database;
//    }

  }
  initDB()async{
    Directory dir =await getApplicationDocumentsDirectory();
    String path= dir.path+'Tasks';
    final taskList= await openDatabase(path,version: 1,onCreate: _onCreate);
    return taskList;
  }
void _onCreate(Database dB,int version) async{
    await dB.execute(
      'CREATE TABLE Tasks'
          '($taskId INTEGER PRIMARY KEY AUTOINCREMENT,'
          '$taskDate TEXT,'
          '$taskDesc TEXT,'
          '$taskImportance TEXT,'
          '$taskStatus TEXT,'
        '$taskTitle TEXT)'


    );

}

//CRUD
insertTask(TaskModel task)async{
Database dBB = await db;
dBB.insert('Tasks', task.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);

 }

  deleteTask(TaskModel task)async{
    Database dBB = await db;
    dBB.delete('Tasks',where:'$taskId=?' ,whereArgs:[task.id] );

  }
  updateTask(TaskModel task)async{
    Database dBB = await db;
    dBB.update('Tasks',task.toJson(),where:'$taskId=?' ,whereArgs:[task.id] );

  }
  getAllTasks()async{
    Database dBB = await db;
        List<Map<String,dynamic>>maps= await dBB.query('Tasks');
        return maps.map((e) => TaskModel.fromJson(e)).toList();

  }
}