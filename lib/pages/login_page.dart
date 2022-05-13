import 'package:flutter/material.dart';
import 'package:todo/pages/cadastrar_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:hive/hive.dart';
import 'package:todo/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  late Box box;
  late bool jaexiste;
  late List _passw;
  LoginPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  Future<void> _startPreferences() async {
    box = await Hive.openBox('cadastro');
  }

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
                onTap: () {
                  _startPreferences();
                },
                decoration: InputDecoration(
                  hintText: 'digite seu email!',
                  label: Text('Email'),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Digite um email!';
                  } else if (EmailValidator.validate(value) == false) {
                    return 'Email inválido!';
                  } else if (jaexiste = false) {
                    return 'Email ou passworld  inválido!';
                  }
                },
                onChanged: (value) {
                  print('Name: ${box.get(value.toString())}');
                  if (box.get(value.toString()) == null) {
                    jaexiste = false;
                    _passw = ['0', '0', '0', '0'];
                    print(_passw.toString());
                  } else {
                    print(value.toString());
                    _passw = box.get(value);
                    print(_passw.toString());
                    jaexiste = true;
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
                    } else if (jaexiste = false) {
                      return 'Email ou passworld  inválido!';
                    } else if (value.toString() != _passw[2].toString()) {
                      print('_passw[2].toString' + value.toString());
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

/*
import 'package:flutter/material.dart';
import 'package:todo/pages/cadastrar_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:hive/hive.dart';
import 'package:todo/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  void Function() => {};

  late Box box;
  late bool jaexiste;
  late List _passw;
  late String login;
  LoginPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  Future<void> _startPreferences() async {
    box = await Hive.openBox('cadastro');
  }

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
                onTap: () {
                  _startPreferences();
                },
                decoration: InputDecoration(
                  hintText: 'digite seu email!',
                  label: Text('Email'),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Digite um email!';
                  } else if (EmailValidator.validate(value) == false) {
                    return 'Email inválido!';
                  } else if (jaexiste = false) {
                    return 'Email ou passworld  inválido!';
                  }
                },
                onChanged: (value) {
                  print('Name: ${box.get(value.toString())}');
                  if (box.get(value.toString()) == null) {
                    jaexiste = false;
                    _passw = ['0', '0', '0', '0'];
                    login = '0';
                    print(_passw.toString());
                  } else {
                    print(value.toString());
                    _passw = box.get(value);
                    print(_passw.toString());
                    jaexiste = true;
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
                    } else if (jaexiste = false) {
                      return 'Email ou passworld  inválido!';
                    } else if (value.toString() != _passw[2].toString()) {
                      print('_passw[2].toString' + value.toString());
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
                    onPressed: () {
                      login = _passw[0].toString();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomePage(title: login, onSave: login),
                        ),
                      );

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
*/
