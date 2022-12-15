import 'package:flutter/material.dart';

class SignUpBackground extends StatelessWidget {
  final Widget child;
  const SignUpBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image(
              image: const AssetImage("assets/images/sign_up_top.png"),
              width: size.width * 0.3,
            ),
          ),
          // Positioned(
          //   bottom: 0,
          //   right: 0,
          //   child: Image(
          //     image: const AssetImage("assets/images/login_bottom.png"),
          //     width: size.width * 0.35,
          //   ),
          // ),
          child,
        ],
      ),
    );
  }
}
