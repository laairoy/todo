<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:hive/hive.dart';
import 'package:todo/pages/home_page.dart';

class CadastrarPage extends StatelessWidget {
  late Box box;
  late String nom;
  late bool jaexiste;
  CadastrarPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _nomeController = TextEditingController();

  Future<void> _startPreferences() async {
    box = await Hive.openBox('cadastro');
  }

  @override
  Widget build(BuildContext context) {
    nom = 'usuario';
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Cadastrar'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Scrollbar(
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                onTap: () {
                                  _startPreferences();
                                },
                                controller: _nomeController,
                                decoration: InputDecoration(
                                  hintText: 'digit seu nome',
                                  label: Text('Nome'),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Digite seu nome!';
                                  }
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    hintText: 'digite seu email!',
                                    label: Text('Email'),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Digite o email!';
                                    } else if (EmailValidator.validate(value) ==
                                        false) {
                                      return 'Email inválido!';
                                    } else if (jaexiste == true)
                                      return 'Email já cadastrado';
                                  },
                                  onChanged: (value) {
                                    //print('Name: ${box.get(value.toString())}');
                                    if (box.get(value.toString()) != null) {
                                      jaexiste = false;
                                      // print(value.toString());
                                    } else {
                                      jaexiste = true;
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      nom = 'errou';
                                      return 'Digite o email!';
                                    } else if (value != _emailController.text) {
                                      return 'email são difirentes!';
                                    }
                                  },
                                  decoration: InputDecoration(
                                    // labelText: 'ccoco',
                                    hintText: 'Repita o email!',
                                    label: Text('Confirmar Email'),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: TextFormField(
                                  controller: _passController,
                                  decoration: InputDecoration(
                                    hintText: 'digita a senha!',
                                    label: Text('Senha'),
                                  ),
                                  obscureText: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Digite uma senha';
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Digite uma senha!';
                                    }
                                    if (value != _passController.text) {
                                      return 'Senhas estão difirentes';
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'repita a senha!',
                                    label: Text('Confirmar Senha'),
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
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        List data = [
                                          _nomeController.text,
                                          _emailController.text,
                                          _passController.text,
                                          true
                                        ];
                                        //print(data);
                                        box.put(_emailController.text, data);
                                        //print('text: ${box.get(_emailController.text)}');
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            '/home',
                                            ModalRoute.withName('/home'));
                                      }
                                      //print(box.get(_emailController.text)[3].toString());
                                    },
                                    child: const Text('Cadastrar'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
=======
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:hive/hive.dart';


class CadastrarPage extends StatelessWidget {
  late Box box;
  late bool jaexiste;
  CadastrarPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
    TextEditingController _nomeController = TextEditingController();



Future<void> _startPreferences() async{
  box = await Hive.openBox('cadastro');
  jaexiste = false;
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Cadastrar'),
      ),
      body: 
      SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Scrollbar(
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
      
      Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            
            children: [
              TextFormField(
                onTap: (){
                  _startPreferences();
                },
                controller: _nomeController,
                
                decoration: InputDecoration(
                  hintText: 'digit seu nome',
                  label: Text('Nome'),
                ),
                validator: (value){
                 
                  if(value!.isEmpty){
                    return 'Digite seu nome!';
                  }
                },
               
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'digite seu email!',
                    label: Text('Email'),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Digite o email!';
                    } else if (EmailValidator.validate(value) == false) {
                      return 'Email inválido!';
                    } else if (jaexiste == true)
                    return 'Email já cadastrado';
                  },
                   onChanged: (value){
                     //print('Name: ${box.get(value.toString())}');
                     if (box.get(value.toString())!.isEmpty){
                       jaexiste=false;
                     // print(value.toString());
                     }else{
                       jaexiste =true;
                     }
                   
                },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Digite o email!';
                    } else if (value != _emailController.text) {
                      return 'email são difirentes!';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Repita o email!',
                    label: Text('Confirmar Email'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(
                    hintText: 'digita a senha!',
                    label: Text('Senha'),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Digite uma senha';
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Digite uma senha!';
                    }
                    if (value != _passController.text) {
                      return 'Senhas estão difirentes';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'repita a senha!',
                    label: Text('Confirmar Senha'),
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
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        List data = [_nomeController.text,
                        _emailController.text,
                        _passController.text,
                        true
                        ];
                        //print(data);
                        box.put(_emailController.text, data);
                        //print('text: ${box.get(_emailController.text)}');
                          Navigator.pushNamedAndRemoveUntil(
                            context, '/home', ModalRoute.withName('/home'));
                      }
                      //print(box.get(_emailController.text)[3].toString());
                    },
                    child: const Text('Cadastrar'),
           
               ),
                              ),
                            ),
                          ],
                        ),
                      

        ))
                      ],
                    ),
                  
              ),
            )
                  ],
                ),
              ),
            );
      
  }
}
>>>>>>> 263d4dc1af19645f95636c13f979b191bde5bf2d
