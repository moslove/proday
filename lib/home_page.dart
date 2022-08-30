import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proday/add_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // final _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  final CollectionReference _mytask = FirebaseFirestore.instance.collection('mytask');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MY TASK'),
        actions: [
          IconButton( icon: Icon(Icons.logout),
          onPressed: ()async { await FirebaseAuth.instance.signOut();
          }
          ),
        ],
      ),

          body: StreamBuilder<QuerySnapshot>(
            stream: _mytask.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){

              if(!streamSnapshot.hasData && streamSnapshot.hasError){
                return Center(child: CircularProgressIndicator());
              }


           else {
                  final datavalue =
                  streamSnapshot.data!.docs.toList();
                  print(datavalue.length);
                  print(datavalue[0].data());
                  return ListView.builder(
                      itemCount : datavalue.length,
                      itemBuilder: (context, index){

                        return SingleChildScrollView(
                          child: Container(

                            decoration: BoxDecoration(color: Colors.grey),
                            child: Card(

                              child: Column(

                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  ListTile(
                                    title: Text('${datavalue[index]['taskname']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    ),
                                  ),


                                  ListTile(
                                    title : Text('${datavalue[index]['description']}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),

                                    ),
                                    subtitle: Text('${datavalue[index]['duration']}' +   'mins',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),

                                    trailing: IconButton(onPressed: () async{
                                      await FirebaseFirestore.instance.collection('mytask').doc('mytask'[index]).delete();
                                    }, icon: Icon(Icons.check_box)),
                                  ),
                                ],
                              ),

                            ),
                          ),
                        );
                      }
                  );
                }
            },
          ),

       floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white ,) ,
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTask()));
        },

      ),
    );
  }

}






