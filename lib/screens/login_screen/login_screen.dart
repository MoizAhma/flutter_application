import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';
import 'package:flutter_application/screens/home_screen/home_screen.dart';
import 'package:flutter_application/screens/login_screen/login_background.dart';
import 'package:flutter_application/screens/reusable_widgets/elevated_button.dart';
import 'package:flutter_application/screens/reusable_widgets/text_button.dart';
import 'package:flutter_application/screens/reusable_widgets/text_form_field.dart';
import 'package:flutter_application/screens/sign_up_screen/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  String error = "";
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: LoginBackground(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 120),
                child: Center(
                  child: Image(
                    image: const AssetImage("assets/images/login_screen.png"),
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
                      text: "Login",
                      textColor: textLightColor,
                      btnColor: kPrimaryColor,
                      press: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await auth.signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          } on FirebaseAuthException catch (e) {
                            if (e.code == "user-not-found" ||
                                e.code == "wrong-password") {
                              setState(() {
                                error = "Invalid email or password";
                              });
                            }
                          }
                        }
                      },
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10, left: 50),
                          child: Text(
                            error.toString(),
                            style: const TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      ],
                    ),
                    ReusableTextButton(
                      text: "Don't have an Account ?",
                      btnText: "SignUp",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
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
