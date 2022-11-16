import 'package:flutter/material.dart';

class LogoMenu extends StatelessWidget {
  const LogoMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        image: const DecorationImage(
            image: AssetImage('assets/images/SignalR-Logopng-1.png'),
            fit: BoxFit.cover),
      ),
    );
  }
}
