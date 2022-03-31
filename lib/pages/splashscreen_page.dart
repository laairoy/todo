import 'package:flutter/material.dart';
import 'package:todo/models/login_data.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LoginData loginData = LoginData();

  @override
  void initState() {
    super.initState();
    _login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //theme: ThemeData.dark(),
      body: Container(
        alignment: Alignment.center,
        child: const Text(
          'TO-DO',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  _login() async {
    Future.delayed(const Duration(seconds: 1), () {
      if (loginData.logged == true) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/home', ModalRoute.withName('/home'));
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, '/login', ModalRoute.withName('/login'));
      }
    });
  }
}
