import 'package:flutter/material.dart';
class ReusableElevatedButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color btnColor;
  final Function()? press;
  const ReusableElevatedButton({
    Key? key, 
    required this.text, 
    required this.textColor, 
    required this.btnColor, 
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 30),
      width: size.width * 0.85,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            primary: btnColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(29),
            ),
          ),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              letterSpacing: 0.5,
            ),
          )),
    );
  }
}
