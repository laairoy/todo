import 'package:flutter/material.dart';
import 'package:todo/models/item_list.dart';
import 'package:todo/repositories/fixed_list_repository.dart';
import 'package:todo/pages/inbox.dart';
import 'package:todo/repositories/list_repository.dart';
import 'package:todo/models/login_data.dart';

import 'add_item.dart';
import '../models/load_list_repository.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: fixedList.length,
              itemBuilder: (context, int index) {
                return ListTile(
                  title: Text(fixedList[index].title),
                  leading: fixedList[index].icon,
                  trailing: const Text('0'),
                  onTap: () => {},
                );
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: loadList.length,
              itemBuilder: (context, int index) {
                return loadList[index].type == ItemType.FOLDER
                    ? ExpansionTile(
                        title: Text(loadList[index].name),
                        leading:
                            Icon(Icons.folder, color: loadList[index].color),
                        childrenPadding: const EdgeInsets.only(left: 10),
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                (loadList[index] as FolderItem).iList.length,
                            itemBuilder: (BuildContext context, int i) {
                              List<ListItem> subList =
                                  (loadList[index] as FolderItem).iList;
                              return ListTile(
                                title: Text(subList[i].name),
                                leading:
                                    Icon(Icons.list, color: subList[i].color),
                                trailing: const Text('0'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Inbox(),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      )
                    : ListTile(
                        title: Text(loadList[index].name),
                        leading: Icon(Icons.list, color: loadList[index].color),
                        trailing: const Text('0'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Inbox(),
                            ),
                          );
                        },
                      );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: ThemeData.dark().bottomAppBarColor,
        child: IconTheme(
          data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddItem(type: ItemType.LIST),
                      ));
                },
                child: Row(
                  children: const [
                    Icon(Icons.add),
                    Text(
                      'Nova Lista',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () => {},
                  icon: const Icon(Icons.bookmark_add)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddItem(type: ItemType.FOLDER),
                      ),
                    );
                  },
                  icon: const Icon(Icons.create_new_folder)),
            ],
          ),
        ),
      ),
    );
  }
}
