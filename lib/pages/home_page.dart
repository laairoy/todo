import 'package:flutter/material.dart';
import 'package:todo/pages/fixed_list.dart';
import 'package:todo/pages/list_repository.dart';
import 'package:todo/pages/login_data.dart';

import 'load_list.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final LoginData loginData = LoginData();
  final List<ItemList> fixedList = FixedList().fixedList;
  final List<Item> loadList = ListRepository().loadList;

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
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: fixedList.length,
            itemBuilder: (context, int index) {
              return ListTile(
                title: Text(fixedList[index].title),
                leading: fixedList[index].icon,
                trailing: const Text('0'),
              );
            },
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: loadList.length,
            itemBuilder: (context, int index) {
              return ListTile(
                title: Text(loadList[index].name),
                leading: loadList[index].type == ItemType.FOLDER
                    ? Icon(Icons.folder, color: loadList[index].color)
                    : Icon(Icons.list, color: loadList[index].color),
                trailing: const Text('0'),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: ThemeData.dark().bottomAppBarColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: [
              const Icon(Icons.add),
              const Text('Nova Lista'),
              const Spacer(),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.bookmark_add)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ));
                  },
                  icon: const Icon(Icons.create_new_folder)),
            ],
          ),
        ),
      ),
    );
  }
}
