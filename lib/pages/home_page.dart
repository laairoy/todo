import 'package:flutter/material.dart';
import 'package:todo/cadastrar.dart';
import 'package:todo/models/item_list.dart';
import 'package:todo/models/task_list.dart';
import 'package:todo/repositories/fixed_list_repository.dart';
import 'package:todo/pages/inbox.dart';
import 'package:todo/repositories/list_repository.dart';
import 'package:todo/models/login_data.dart';
import 'package:todo/repositories/task_list_repository.dart';

import '../login.dart';
import 'add_item.dart';
import '../models/load_list_repository.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginData loginData = LoginData();

  final List<ItemList> fixedList = FixedList().fixedList;
  List<TaskList> taskList = TaskListRepository.instance.table;
  late ListRepository listRepository;
  List<Item> loadList = [];

  @override
  void initState() {
    super.initState();
    listRepository = ListRepository.instance;
    loadList = listRepository.loadList;
  }

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
                    ? GestureDetector(
                        onLongPress: () => print('ola'),
                        child: ExpansionTile(
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
                                return buildListTile(subList, i, context,
                                    folderId: index);
                              },
                            ),
                          ],
                        ),
                      )
                    : buildListTile(loadList, index, context);
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
                  openAddItem(context, ItemType.LIST);
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
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login()))
                      },
                  icon: const Icon(Icons.bookmark_add)),
              IconButton(
                  onPressed: () {
                    openAddItem(context, ItemType.FOLDER);
                  },
                  icon: const Icon(Icons.create_new_folder)),
            ],
          ),
        ),
      ),
    );
  }

  ListTile buildListTile(var list, int i, BuildContext context,
      {int? folderId}) {
    return ListTile(
      title: Text(list[i].name),
      leading: Icon(Icons.list, color: list[i].color),
      trailing: Text(taskCountFilter(list, i).toString()),
      onLongPress: () {
        openAddItem(context, ItemType.LIST, id: i, folderId: folderId);
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Inbox(
              listItem: list[i],
              onSave: updateList,
            ),
          ),
        );
      },
    );
  }

  void openAddItem(BuildContext context, ItemType type,
      {int? id, int? folderId}) {
    print(folderId);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddItem(
          type: type,
          onSave: updateList,
          id: id,
          currFolderId: folderId,
        ),
      ),
    );
  }

  void updateList() {
    setState(() {
      loadList = listRepository.loadList;
      taskList = TaskListRepository.instance.table;
    });
  }

  int taskCountFilter(var list, int index) {
    return taskList
        .where((element) => element.listId == list[index].id)
        .where((element) => element.finished == false)
        .length;
  }
}
