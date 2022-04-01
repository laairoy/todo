import 'package:flutter/material.dart';
import 'package:todo/models/fixed_list_type.dart';
import 'package:todo/models/task_list.dart';
import 'package:todo/pages/inbox.dart';
import 'package:todo/pages/time_task.dart';
import 'package:todo/repositories/list_repository.dart';
import 'package:todo/models/login_data.dart';
import 'package:todo/repositories/task_list_repository.dart';

import 'add_item.dart';
import '../models/load_list_repository.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginData loginData = LoginData();

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
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ListTile(
                  title: Text('Hoje'),
                  leading: Icon(Icons.sunny, color: Colors.green),
                  trailing:
                      Text(filterTable(FixedListType.HOJE).length.toString()),
                  onTap: () => openDateFilter(FixedListType.HOJE, 'Hoje'),
                ),
                ListTile(
                  title: Text('Amanhã'),
                  leading: Icon(Icons.wb_twilight, color: Colors.redAccent),
                  trailing:
                      Text(filterTable(FixedListType.AMANHA).length.toString()),
                  onTap: () => openDateFilter(FixedListType.AMANHA, 'Amanha'),
                ),
                ListTile(
                  title: Text('Em Breve'),
                  leading: Icon(Icons.calendar_month, color: Colors.blueAccent),
                  trailing: Text(
                      filterTable(FixedListType.EMBREVE).length.toString()),
                  onTap: () =>
                      openDateFilter(FixedListType.EMBREVE, 'Em Breve'),
                ),
                ListTile(
                  title: Text('Algum Dia'),
                  leading: Icon(Icons.calendar_today,
                      color: Colors.deepPurpleAccent),
                  trailing: Text(
                      filterTable(FixedListType.ALGUMDIA).length.toString()),
                  onTap: () =>
                      openDateFilter(FixedListType.ALGUMDIA, 'Algum Dia'),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: loadList.length,
              itemBuilder: (context, int index) {
                return loadList[index].type == ItemType.FOLDER
                    ? GestureDetector(
                        onLongPress: () => openAddItem(context, ItemType.FOLDER,
                            id: index),
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
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: const [
                      Icon(Icons.add),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Nova Lista',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
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

  void openDateFilter(FixedListType type, String title) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TimeTaskList(
                type: type,
                title: title,
                filterTable: filterTable,
                onSave: updateList)));
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

  List<TaskList> filterTable(FixedListType type) {
    switch (type) {
      case FixedListType.HOJE:
        {
          return TaskListRepository.instance.table
              .where((element) =>
                  element.date == DateTime.now().toString().substring(0, 10))
              .where((element) => element.finished == false)
              .toList();
        }
      case FixedListType.AMANHA:
        {
          return TaskListRepository.instance.table
              .where((element) =>
                  element.date ==
                  DateTime.now()
                      .add(Duration(days: 1))
                      .toString()
                      .substring(0, 10))
              .where((element) => element.finished == false)
              .toList();
        }
      case FixedListType.EMBREVE:
        {
          return TaskListRepository.instance.table
              .where((element) => element.date != '')
              .where((element) => element.finished == false)
              .toList();
        }
    }
    return TaskListRepository.instance.table
        .where((element) => element.date == '')
        .where((element) => element.finished == false)
        .toList();
  }
}
