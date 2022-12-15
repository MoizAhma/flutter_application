import 'package:flutter/material.dart';
import 'package:flutter_application/constants.dart';

class ReusableTextButton extends StatelessWidget {
  final String text;
  final Function() press;
  final String btnText;
  const ReusableTextButton({
    Key? key,
    required this.text,
    required this.press,
    required this.btnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            text,
            style: const TextStyle(
              color: textDarkColor,
            ),
          ),
          TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: press,
            child: Text(
              btnText,
              style: const TextStyle(
                color: textDarkColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
