import 'package:flutter/material.dart';
import 'package:todo/pages/cadastrar_page.dart';
import 'package:email_validator/email_validator.dart';


class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'digite seu email!',
                  label: Text('Email'),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Digite um email!';
                  }
                  else if(EmailValidator.validate(value) == false ){
                    return 'Email inválido!' ;
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'digita a senha!',
                    label: Text('Senha'),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Digite sua senha!';
                    }
                  },
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
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/home', ModalRoute.withName('/home'));
                      }
                    },
                    child: const Text('Logar'),
                  ),
                ),
              ),
              TextButton(onPressed: () {}, child: Text('Esqueceu sua senha?')),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Divider(
                  thickness: 2,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CadastrarPage()));
                    },
                    child: const Text('Criar Conta'),
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
