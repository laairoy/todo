import 'package:flutter/material.dart';

class CadastrarPage extends StatelessWidget {
  CadastrarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'digite seu email!',
                  label: Text('Email'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'digita a senha!',
                    label: Text('Senha'),
                  ),
                  obscureText: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: SizedBox(
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
              ),

            ],
          ),
        ),
      ),
    );
  }
}
