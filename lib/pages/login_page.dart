import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'digite seu email!',
                  label: Text('Email'),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'digita a senha!',
                  label: Text('Senha'),
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/home', ModalRoute.withName('/home'));
                  },
                  child: const Text('Logar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
