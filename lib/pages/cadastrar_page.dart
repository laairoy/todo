import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class CadastrarPage extends StatelessWidget {
  CadastrarPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Cadastrar'),
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
                    return 'Digite o email!';
                  } else if (EmailValidator.validate(value) == false) {
                    return 'Email inválido!';
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Digite o email!';
                    } else if (value != _emailController.text) {
                      return 'Senhas são difirentes!';
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
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Digite uma senha';
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(
                  validator: (value) {
                    if(value!.isEmpty){
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
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Cadastrar'),
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
