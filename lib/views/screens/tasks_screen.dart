import 'package:flutter/material.dart';
import 'package:smarttaskapp/controler/sql_helper.dart';
import 'package:smarttaskapp/models/task_model.dart';
import 'package:smarttaskapp/views/screens/add_task_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:smarttaskapp/views/screens/update_screen.dart';

class Tasks extends StatefulWidget {
  static String id = 'Tasks';

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
 bool check=false;

  List<TaskModel>?taskList = [];
  DBHelper dbHelper = DBHelper();

  getTasks() {
    dbHelper.getAllTasks().then((v) {
      setState(() {
        taskList = v;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTasks();

  }

  @override
  Widget build(BuildContext context) {
    getTasks();
    return Scaffold(
        appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,title:Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text('SmartCode',style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold),),
    Text(
    'Tasks',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),

    ],) ),
    floatingActionButton: FloatingActionButton(onPressed: () {
    Navigator.pushNamed(context, AddTask.id);
    },child: Icon(Icons.add),),
    body:FutureBuilder(
      builder: (context,s)=>
      ListView.builder(
      itemCount:
      taskList!.length,
      itemBuilder: (context,index)=>Padding(
      padding: const EdgeInsets.only(right: 8,left: 8,bottom: 8),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
secondaryActions: [
  IconSlideAction(
      caption: 'Delete',
      color: Colors.black26,
      icon: Icons.delete,
      onTap: ()async {
        await dbHelper.deleteTask(taskList![index]);
      } ,
  ),
  IconSlideAction(
      caption: 'Edit',
      color: Colors.blueGrey,
      icon: Icons.edit,
      onTap: () {

        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>UpdateTask(
          taskList![index]

        ) ));
      } ,
  ),
],

        child: InkWell(
          onTap: (){
            setState(() {
              taskList![index].status=='1';
              taskList![index].title=='1';
              dbHelper.updateTask(taskList![index]);
              getTasks();


            });
            print(taskList![index].title);
            print(taskList![index].status);

          },
          child: Container(
          width:double.infinity ,
          height: 120,
          color: Colors.indigo,
          child: ListTile(
          title: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(taskList==null?'title':taskList![index].title!,
          style: TextStyle(color: Colors.white,fontSize: 18,
             // decoration: check==true?TextDecoration.lineThrough:TextDecoration.none
          ), ),
          ),
          subtitle: Text(taskList==null?'No Description':taskList![index].desc!,
          style: TextStyle(color: Colors.white,fontSize: 14,
              //decoration: check==true?TextDecoration.lineThrough:TextDecoration.none
          ), ),
            trailing: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Checkbox(value:taskList![index].status=='0'?false:true ,onChanged: (v){
               setState(() {
                // taskList![index]!=v;
                 //check!=v;
                   if(taskList![index].status=='0'){
                     taskList![index].status=='1';
                     //check=!check;
                   }else{
                     taskList![index].status=='0';
                     //check=!check;

                   }
                   dbHelper.updateTask(taskList![index]);
                   getTasks();


               });

              },),
            ),

          )
          ,
          ),
        ),
      )
      ,
      )
      ),
    ));
  }
}
