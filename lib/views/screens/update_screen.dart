import 'package:flutter/material.dart';
import 'package:smarttaskapp/controler/sql_helper.dart';
import 'package:smarttaskapp/models/task_model.dart';
import 'package:smarttaskapp/views/screens/tasks_screen.dart';
import 'package:smarttaskapp/views/widgets/custom_textFormField.dart';

class UpdateTask extends StatefulWidget {
  TaskModel? model;


  UpdateTask(this.model);

  @override
  _UpdateTaskState createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {



  DBHelper dbHelper=DBHelper();
  List<TaskModel>?taskList=[];

  String title='';
  String desc='';
  String imp='';

  TextEditingController controllerDate= TextEditingController();
  TextEditingController controllerTitle= TextEditingController();
  TextEditingController controllerDesc= TextEditingController();
  TextEditingController controllerImp= TextEditingController();





  GlobalKey<FormState>key=GlobalKey<FormState>();
  var i;
  List<String>list=[
    'low','intermediate','high'
  ];
  showDate()async{
    DateTime? date =await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1990), lastDate: DateTime(2030));
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    controllerDate.text=widget.model!.date.toString();
    controllerDesc.text=widget.model!.desc.toString();
    controllerImp.text=widget.model!.importance.toString();
    controllerTitle.text=widget.model!.title.toString();

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
                    child: Text('Update Task',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),textAlign: TextAlign.start,)),
                SizedBox(height: 20,),
                Form(key: key,
                    child: Column(children: [
                      CustomTextFormField(labeltext: 'Task Title',controller:controllerTitle ,onSaved: (v){
                        setState(() {
                         title!=v;
                         controllerTitle.text=v;

                        });
                      },),
                      SizedBox(height: 20,),
                      CustomTextFormField(labeltext: 'Task Date' ,onTap: showDate,readOnly: true,controller: controllerDate,onSaved: (v){
                        setState(() {
                          widget.model!.date!=v;

                        });
                      },
                        validator: (v){
                          if(v==null)return 'please enter title';
                        },),
                      SizedBox(height: 20,),
                      CustomTextFormField(labeltext: 'Task Description',maxlines: 3,controller: controllerDesc,onSaved: (v){
                        setState(() {
                          controllerDesc.text=v;
                          desc!=v;

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
                        setState(() {
                          widget.model!.title=title;
                          widget.model!.desc=desc;
                        });


                        dbHelper.updateTask(widget.model!);

                        final snackBar = SnackBar(content: Text('Done!',),backgroundColor: Colors.green,);

// Fin
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      }




                    },
                    child: Container(
                      height:45 ,
                      width: MediaQuery.of(context).size.width*0.5,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(child: Text('Update Task',textAlign: TextAlign.center,style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold))),))

              ],),
          ),
        ),
      ),
    );
  }
}