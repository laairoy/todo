import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/login_data.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  LoginData loginData = LoginData();

  var itens = {
    'Hoje': Icons.sunny,
    'Amanhã': Icons.wb_twilight,
    'Em Breve': Icons.calendar_month,
    'Algum dia': Icons.calendar_today,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(loginData.nome),
        leading: Container(
          padding: const EdgeInsets.all(5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image(
              image: AssetImage(loginData.avatar),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: itens.length,
        itemBuilder: (context, int index) {
          var itensKey = itens.keys.toList();
          var itensValue = itens.values.toList();

          return ListTile(
            title: Text(itensKey[index]),
            leading: Icon(
              itensValue[index],
              color: Colors.green,
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: [
              Icon(Icons.add),
              Text('Nova Lista'),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.bookmark_add)),
              IconButton(onPressed: () {}, icon: Icon(Icons.create_new_folder)),
            ],
          ),
        ),
      ),
    );
  }
}
