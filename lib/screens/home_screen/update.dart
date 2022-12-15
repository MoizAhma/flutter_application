import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';
import 'package:flutter_application/screens/home_screen/home_screen.dart';
import 'package:flutter_application/screens/home_screen/showdata.dart';
import 'package:flutter_application/screens/login_screen/login_screen.dart';
import 'package:flutter_application/screens/reusable_widgets/elevated_button.dart';
import 'package:flutter_application/screens/reusable_widgets/text_form_field.dart';
import 'package:flutter_application/student.dart';


class update extends StatefulWidget {
  @override
  State<update> createState() => _HomeScreenState();
  String? id;
  Student? student;
  AsyncSnapshot<QuerySnapshot<Object?>>? snapshot;
  update({this.id, this.snapshot, this.student});
}

class _HomeScreenState extends State<update> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var gender = ['Male', 'Female', 'Other'];
  var genderSelected = "Male";
  var degree_program = ['BSSE', 'BSCS', 'BSIT', 'BSAI'];
  var degreeeSelected = "BSSE";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() {
    nameController = new TextEditingController(text: widget.student!.name);
    ageController =
        new TextEditingController(text: widget.student!.age.toString());
    cgpaController =
        new TextEditingController(text: widget.student!.cgpa.toString());
  }

  TextEditingController? nameController;
  TextEditingController? ageController;
  TextEditingController degreeController = new TextEditingController();
  TextEditingController? cgpaController;
  final TextEditingController genderController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  'Student Record',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Container(
                  child: ReusableTextFormField(
                      hintText: "Name",
                      controller: nameController!,
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      textInputType: TextInputType.name,
                      actionKeyboard: TextInputAction.next,
                      textValidate: "Name is required")),
              Container(
                  child: ReusableTextFormField(
                      hintText: "Age",
                      controller: ageController!,
                      prefixIcon: Icon(
                        Icons.star,
                        color: Colors.black,
                      ),
                      textInputType: TextInputType.number,
                      actionKeyboard: TextInputAction.next,
                      textValidate: "Age is required")),
              Container(
                  child: ReusableTextFormField(
                      hintText: "CGPA",
                      controller: cgpaController!,
                      prefixIcon: Icon(
                        Icons.calendar_month,
                        color: Colors.black,
                      ),
                      textInputType: TextInputType.number,
                      actionKeyboard: TextInputAction.next,
                      textValidate: "CGPA is required")),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                margin:
                    EdgeInsets.only(left: 29, right: 29, top: 15, bottom: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: kPrimaryLightColor,
                  border: Border.all(
                      color: Colors.transparent,
                      style: BorderStyle.solid,
                      width: 0.80),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: degree_program.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    isExpanded: true,
                    onChanged: (String? newValueSelected) {
                      setState(() {
                        degreeeSelected = newValueSelected!;
                      });
                    },
                    value: degreeeSelected,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                margin: EdgeInsets.only(left: 29, right: 29),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: kPrimaryLightColor,
                  border: Border.all(
                      color: Colors.transparent,
                      style: BorderStyle.solid,
                      width: 0.80),
                  // color: Colors.white
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: gender.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    isExpanded: true,
                    onChanged: (String? newValueSelected) {
                      setState(() {
                        genderSelected = newValueSelected!;
                        print(genderSelected);
                      });
                    },
                    value: genderSelected,
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 80),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(180, 50),
                    ),
                    onPressed: () {
                      Student student = Student(
                          name: nameController!.text,
                          age: int.parse(ageController!.text),
                          cgpa: double.parse(cgpaController!.text),
                          gender: genderSelected,
                          degreeProgram: degreeeSelected);
                      FirebaseFirestore.instance
                          .collection("TMS")
                          .doc(widget.id)
                          .set(student.toJson())
                          .whenComplete(
                            () => print("update Record Successfully"),
                          )
                          .catchError((e) {
                        print(e);
                      });
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => ShowData()));
                    },
                    child: Text(
                      "update Data",
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
            ],
          ),
        ),
      )),
    );
  }
}
