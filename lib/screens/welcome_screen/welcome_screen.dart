import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';
import 'package:flutter_application/screens/login_screen/login_screen.dart';
import 'package:flutter_application/screens/reusable_widgets/elevated_button.dart';
import 'package:flutter_application/screens/sign_up_screen/sign_up_screen.dart';
import 'package:flutter_application/screens/welcome_screen/background.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BackGround(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 130),
                child: Center(
                  child: Image(
                    image: const AssetImage("assets/images/welcome_screen.png"),
                    height: size.height * 0.45,
                  ),
                ),
              ),
              ReusableElevatedButton(
                text: "Login",
                textColor: textLightColor,
                btnColor: kPrimaryColor,
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
              ),
              ReusableElevatedButton(
                text: "SignUp",
                textColor: textDarkColor,
                btnColor: kPrimaryLightColor,
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
