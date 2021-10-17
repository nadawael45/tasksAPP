import 'package:flutter/material.dart';
import 'package:smarttaskapp/views/screens/add_task_screen.dart';
import 'package:smarttaskapp/views/screens/tasks_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.indigo,
      ),
      initialRoute:  Tasks.id,
      routes: {
        AddTask.id:(context)=>AddTask(),
        Tasks.id:(context)=>Tasks(),
      },
    );
  }
}


