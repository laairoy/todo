import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/models/item_list.dart';
import 'package:todo/models/login_data.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:todo/models/task_list.dart';

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
    bool firstRun = await IsFirstRun.isFirstCall();
    if (firstRun) {
      _initData();
    }
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

  _initData() {
    Hive.box("item_list").addAll([
      ListItem(name: 'Livros', color: Colors.red),
      FolderItem(name: 'UTFPR', color: Colors.green),
      ListItem(name: 'Testes', color: Colors.blueAccent, folderId: 1),
      FolderItem(name: 'Tarefas', color: Colors.blueAccent),
      ListItem(name: 'Trabalho', color: Colors.greenAccent, folderId: 3),
      ListItem(name: 'Escola', color: Colors.yellowAccent, folderId: 3),
      ListItem(name: 'Casa', color: Colors.purple),
    ]);

    Hive.box("task_list").addAll([
      TaskList(
        name: 'Estudar',
        date: '10/05/2022',
        note: 'pampampam',
        finished: false,
        listId: 0,
      ),
      TaskList(
        name: 'Correr',
        date: '11/05/2022',
        note: 'punpunpun',
        finished: false,
        listId: 0,
      ),
      TaskList(
        name: 'Ler Harry',
        date: '12/06/2023',
        note: 'parapapapapara',
        finished: true,
        listId: 0,
      ),
      TaskList(
        name: 'varrer a casa',
        date: '',
        note: 'pipopipopoi',
        finished: false,
        listId: 2,
      ),
    ]);
  }
}
