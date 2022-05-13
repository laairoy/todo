import 'package:flutter/material.dart';
import 'package:todo/pages/cadastrar_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:hive/hive.dart';

class LoginPage extends StatelessWidget {
  late Box box;
  late bool jaexiste;

  LoginPage({Key? key}) : super(key: key) {
    box = Hive.box('cadastro');
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'digite seu email!',
                  label: Text('Email'),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Digite um email!';
                  } else if (EmailValidator.validate(value) == false) {
                    return 'Email inválido!';
                  }
                },
                onChanged: (value) {
                  //print('Name: ${box.get(value.toString())}');

                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(
                    hintText: 'digita a senha!',
                    label: Text('Senha'),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Digite sua senha!';
                    } else if (jaexiste == false) {
                      return 'Email ou passworld  inválido!';
                    } else if (value.toString() != box.get(_emailController.text.trim()).password) {
                      jaexiste = false;
                      return 'Email ou passworld  inválido!';
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
                    onPressed: () {if (
                    box.get(_emailController.text.trim()) == null) {
                      jaexiste = false;
                    } else {
                      //print(value.toString());
                      //_email = box.get(value.trim()).email;
                      jaexiste = true;
                    }
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                          ModalRoute.withName('/home'),
                          arguments: box.get(_emailController.text.trim()),
                        );
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
