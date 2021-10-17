import 'package:flutter/material.dart';
import 'package:smarttaskapp/controler/sql_helper.dart';
import 'package:smarttaskapp/models/task_model.dart';
import 'package:smarttaskapp/views/screens/tasks_screen.dart';
import 'package:smarttaskapp/views/widgets/custom_textFormField.dart';

class AddTask extends StatefulWidget {
  static String id='addTask' ;

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  DBHelper dbHelper=DBHelper();
  List<TaskModel>?taskList=[];

  String title='';
  String desc='';
  String imp='';
  TextEditingController controllerDate= TextEditingController();



  GlobalKey<FormState>key=GlobalKey<FormState>();
  var i;
  List<String>list=[
    'low','intermediate','high'
  ];
  showDate()async{
  DateTime? date =await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1990), lastDate: DateTime(2030));
setState(() {
  controllerDate.text=date.toString();
});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(color: Colors.indigo,),
      ),
      body: SingleChildScrollView(
        child:
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
              Align(alignment: Alignment.topLeft,
                  child: Text('Add Task',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.start,)),
              SizedBox(height: 20,),
              Form(key: key,
                  child: Column(children: [
                    CustomTextFormField(labeltext: 'Task Title',onSaved: (v){
                      setState(() {
                        title=v;

                      });
                    },),
                    SizedBox(height: 20,),
                    CustomTextFormField(labeltext: 'Task Date' ,onTap: showDate,readOnly: true,controller: controllerDate,
                      validator: (v){
                      if(v==null)return 'please enter title';
                      },),
                    SizedBox(height: 20,),
                    CustomTextFormField(labeltext: 'Task Description',maxlines: 3,onSaved: (v){
                  setState(() {
                  desc=v;

                  });
                  }),
                    SizedBox(height: 20,),


                  ],)),
              SizedBox(height: 20,),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height*0.12,
                  width:MediaQuery.of(context).size.width*0.5,
                  child: ListView.builder(
                    itemCount: list.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index)=>
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(value: index, groupValue: i, onChanged: (v){
                                setState(() {
                                  i=v;
                                  imp=list[i];

                                });
                              }),
                              Text(list[index]),
                            ],
                          )),
                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                  onTap: (){
                   if(key.currentState!.validate()) {
                     key.currentState!.save();
                     dbHelper.insertTask(TaskModel(
                       status:'0',date: controllerDate.text,title:title ,desc:desc ,importance:imp ,
                     ));

                     final snackBar = SnackBar(content: Text('Done!',),backgroundColor: Colors.green,);
                     ScaffoldMessenger.of(context).showSnackBar(snackBar);

                   }

                    print(controllerDate.text);
                    print(desc);
                    print(title);
                   print(imp);


                  },
                  child: Container(
                height:45 ,
                  width: MediaQuery.of(context).size.width*0.5,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(child: Text('Add Task',textAlign: TextAlign.center,style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold))),))

            ],),
          ),
        ),
      ),
    );
  }
}
