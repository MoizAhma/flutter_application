import 'package:flutter/material.dart';
class LoginBackground extends StatelessWidget {
  final Widget child;
  const LoginBackground({
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
              image: const AssetImage("assets/images/main_top.png"),
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
