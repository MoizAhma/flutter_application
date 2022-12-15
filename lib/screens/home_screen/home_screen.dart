import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';
import 'package:flutter_application/screens/home_screen/showdata.dart';
import 'package:flutter_application/screens/reusable_widgets/elevated_button.dart';
import 'package:flutter_application/screens/reusable_widgets/text_form_field.dart';
import 'package:flutter_application/student.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var gender = ['Male', 'Female', 'Other'];
  var genderSelected = "Male";
  var degree_program = ['BSSE', 'BSCS', 'BSIT', 'BSAI'];
  var degreeeSelected = "BSSE";
  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController cgpacontroller = TextEditingController();
  TextEditingController degreecontroller = TextEditingController();
  TextEditingController gendercontroller = TextEditingController();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 80),
              child: Text(
                "Record",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                child: ReusableTextFormField(
                    hintText: "Name",
                    controller: namecontroller,
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
                    controller: agecontroller,
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
                    controller: cgpacontroller,
                    prefixIcon: Icon(
                      Icons.calendar_month,
                      color: Colors.black,
                    ),
                    textInputType: TextInputType.number,
                    actionKeyboard: TextInputAction.next,
                    textValidate: "CGPA is required")),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              margin: EdgeInsets.only(left: 29, right: 29, top: 15, bottom: 15),
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
            ReusableElevatedButton(
              text: "Add Data",
              textColor: textLightColor,
              btnColor: kPrimaryColor,
              press: () async {
                Student student = Student(
                    name: namecontroller.text,
                    age: int.parse(agecontroller.text),
                    cgpa: double.parse(cgpacontroller.text),
                    gender: genderSelected,
                    degreeProgram: degreeeSelected);
                await _firestore
                    .collection("TMS")
                    .doc()
                    .set(student.toJson())
                    .whenComplete(
                      () =>ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Added Succesfully",style: TextStyle(color: Colors.black),),
                duration: Duration(milliseconds: 500),
                backgroundColor: Colors.amber,
              ))
                    )
                    .catchError((e) {
                  print(e);
                  
                });
              },
            ),
            ReusableElevatedButton(
              text: "Show Data",
              textColor: textLightColor,
              btnColor: kPrimaryColor,
              press: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ShowData()));
              },
            )
          ],
        ),
      ),
    );
  }
}
