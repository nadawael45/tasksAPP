import '../constants.dart';

class TaskModel{
  String?title;
  String?date;
  String?desc;
  String?importance;
  String?status;
  int? id;

  TaskModel({this.title, this.date, this.desc, this.importance, this.status,this.id});


  toJson(){
    return{
      '$taskId':id,
      '$taskDate':date,
      '$taskDesc':desc,
      '$taskImportance':importance,
      '$taskStatus':status,
      '$taskTitle':title,


    };
  }
  TaskModel.fromJson(Map<String,dynamic>taskMap){
id=taskMap[taskId];
date=taskMap[taskDate];
title=taskMap[taskTitle];
desc=taskMap[taskDesc];
importance=taskMap[taskImportance];
status=taskMap[taskStatus];

  }
}