import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


  class AddTask extends StatefulWidget {
    const AddTask({Key? key}) : super(key: key);

    @override
    State<AddTask> createState() => _AddTaskState();
  }

  class _AddTaskState extends State<AddTask> {

   final user = FirebaseAuth.instance.currentUser;

    TextEditingController _taskNameController = TextEditingController();
    TextEditingController _taskDescriptionController = TextEditingController();
    TextEditingController _durationController = TextEditingController();

    @override
    void dispose(){
     _taskDescriptionController.dispose();
     _durationController.dispose();
     _taskNameController.dispose();
     super.dispose();
    }

  Future myTask(String name, String describe , String time) async {
 try{

   await FirebaseFirestore.instance.collection('mytask').add({
     'taskname': name,
     'description': describe,
     'duration': time,
   });


 }catch(e,s){

   print(e.toString());
   print(s);
 }
    }
 

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('New Task'),),

        body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  child: TextField(
                    controller: _taskNameController,
                    decoration: InputDecoration(
                      labelText: 'Enter Task Name',
                      border: OutlineInputBorder()
                    ),
                  ),
                ),

                SizedBox(height: 10),

                Container(
                  child: TextField(
                    controller: _taskDescriptionController,
                    decoration: InputDecoration(

                        labelText: 'Enter Task Description',
                        border: OutlineInputBorder()
                    ),
                  ),
                ),

                SizedBox(height: 10),

                Container(
                  child: TextField(
                    controller: _durationController,
                    decoration: InputDecoration(
                        labelText: 'Enter Duration in minutes',
                        border: OutlineInputBorder()
                    ),
                  ),
                ),

                SizedBox(height:10 ),

                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>
                        ((Set<MaterialState> states){
                          if (states.contains(MaterialState.pressed))
                            return Colors.grey;
                          return Theme.of(context).primaryColor;
                      }
                      )),

                    child: Text('Add Task',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                    ),),
                    onPressed:() { myTask(
                      _taskNameController.text.trim(),
                      _taskDescriptionController.text.trim(),
                      _durationController.text.trim(),
                    );
                 Navigator.pop(context);

                      },

                  ),
                ),
              ],
            ),
        ),

      );
    }
  }
