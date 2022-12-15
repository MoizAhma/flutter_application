import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';
import 'package:flutter_application/screens/home_screen/home_screen.dart';
import 'package:flutter_application/screens/home_screen/update.dart';
import 'package:flutter_application/screens/login_screen/login_screen.dart';
import 'package:flutter_application/screens/reusable_widgets/elevated_button.dart';
import 'package:flutter_application/screens/reusable_widgets/text_form_field.dart';
import 'package:flutter_application/student.dart';

class ShowData extends StatefulWidget {
  const ShowData({Key? key}) : super(key: key);

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Record"),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("TMS").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData == false) {
                    return Text("");
                  }
                  var snapshotcount = snapshot.data?.docs.length;
                  return ListView.builder(
                    itemCount: snapshotcount,
                    itemBuilder: (BuildContext context, index) {
                      var id = snapshot.data?.docs[index].id;
                      Student student = Student.fromJson(
                          snapshot.data?.docs[index].data()
                              as Map<String, dynamic>);
                      return Card(
                          child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Text(
                                      "Name: ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text("${student.name}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Age: ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text("${student.age}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Gender: ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text("${student.gender}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Cgpa: ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text("${student.cgpa}"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Degree Program: ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text("${student.degreeProgram}"),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            Student student = Student.fromJson(
                                                snapshot.data?.docs[index]
                                                        .data()
                                                    as Map<String, dynamic>);
                                            return update(
                                              id: snapshot.data?.docs[index].id,
                                              student: student,
                                              snapshot: snapshot,
                                            );
                                          }));
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("TMS")
                                              .doc(id)
                                              .delete();
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ));
                    },
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, left: 300),
            child: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                }),
          )
        ],
      ),
    );
  }
}
