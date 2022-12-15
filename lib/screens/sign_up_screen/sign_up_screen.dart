import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';
import 'package:flutter_application/screens/login_screen/login_screen.dart';
import 'package:flutter_application/screens/reusable_widgets/elevated_button.dart';
import 'package:flutter_application/screens/reusable_widgets/text_button.dart';
import 'package:flutter_application/screens/reusable_widgets/text_form_field.dart';
import 'package:flutter_application/screens/sign_up_screen/sign_up_background.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SignUpBackground(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 120),
                child: Center(
                  child: Image(
                    image: const AssetImage("assets/images/sign_up_screen.png"),
                    height: size.height * 0.35,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    ReusableTextFormField(
                      hintText: "Email",
                      prefixIcon: const Icon(Icons.email, color: kPrimaryColor),
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      actionKeyboard: TextInputAction.next,
                      textValidate: "Email is required",
                    ),
                    ReusableTextFormField(
                      obscureText: isObscure,
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.lock, color: kPrimaryColor),
                      controller: passwordController,
                      textInputType: TextInputType.text,
                      actionKeyboard: TextInputAction.done,
                      textValidate: "Password is required",
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                          color: kPrimaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                      ),
                    ),
                    ReusableElevatedButton(
                      text: "SignUp",
                      textColor: textLightColor,
                      btnColor: kPrimaryColor,
                      press: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await auth.createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          } on FirebaseAuthException catch (e) {
                            print(e.code);
                            if (e.code == 'email-already-in-use') {
                              print(
                                  'The account already exists for that email.');
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text("Alert Box"),
                                  content: const Text(
                                      "The account already exists for that email."),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Container(
                                        //color: Colors.green,
                                        padding: const EdgeInsets.all(14),
                                        child: const Text("okay"),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                        }
                      },
                    ),
                    ReusableTextButton(
                      text: "Already have an Account ?",
                      btnText: "SignIn",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
