import 'package:flutter/material.dart';
import 'package:is_first_run/is_first_run.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //LoginData loginData = LoginData();

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
    bool firstRun = await IsFirstRun.isFirstCall();
    if (firstRun) {
      //_initData();
    }
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', ModalRoute.withName('/login'));
      // if (loginData.logged == true) {
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, '/home', ModalRoute.withName('/home'));
      // } else {
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, '/login', ModalRoute.withName('/login'));
      // }
    });
  }

}
