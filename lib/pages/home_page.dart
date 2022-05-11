import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/models/fixed_list_type.dart';
import 'package:todo/models/task_list.dart';
import 'package:todo/pages/inbox.dart';
import 'package:todo/pages/time_task.dart';
import 'package:todo/models/login_data.dart';
import 'package:todo/repositories/task_list_repository.dart';
import 'package:date_format/date_format.dart';

import 'add_item.dart';
import '../models/item_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginData loginData = LoginData();

  List<TaskList> taskList = TaskListRepository.instance.table;
  List<Item> loadList = Hive.box("item_list").values.toList().cast<Item>();

  @override
  void initState() {
    super.initState();
    loadList.sort((a, b) => a.orderId.compareTo(b.orderId));
  }

  @override
  Widget build(BuildContext context) {
    List<Item> localList = loadList
        .where((element) => (element.type == ItemType.FOLDER ||
            (element.type == ItemType.LIST &&
                (element as ListItem).folderId == -1)))
        .toList();

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
                  title: const Text('Hoje'),
                  leading: const Icon(Icons.sunny, color: Colors.green),
                  trailing:
                      Text(filterTable(FixedListType.HOJE).length.toString()),
                  onTap: () => openDateFilter(FixedListType.HOJE, 'Hoje'),
                ),
                ListTile(
                  title: const Text('Amanhã'),
                  leading:
                      const Icon(Icons.wb_twilight, color: Colors.redAccent),
                  trailing:
                      Text(filterTable(FixedListType.AMANHA).length.toString()),
                  onTap: () => openDateFilter(FixedListType.AMANHA, 'Amanha'),
                ),
                ListTile(
                  title: const Text('Em Breve'),
                  leading: const Icon(Icons.calendar_month,
                      color: Colors.blueAccent),
                  trailing: Text(
                      filterTable(FixedListType.EMBREVE).length.toString()),
                  onTap: () =>
                      openDateFilter(FixedListType.EMBREVE, 'Em Breve'),
                ),
                ListTile(
                  title: const Text('Algum Dia'),
                  leading: const Icon(Icons.calendar_today,
                      color: Colors.deepPurpleAccent),
                  trailing: Text(
                      filterTable(FixedListType.ALGUMDIA).length.toString()),
                  onTap: () =>
                      openDateFilter(FixedListType.ALGUMDIA, 'Algum Dia'),
                ),
                ListTile(
                  title: const Text('Concluídos'),
                  leading:
                      const Icon(Icons.check_circle, color: Colors.white60),
                  trailing:
                      Text(filterTable(FixedListType.DONE).length.toString()),
                  onTap: () => openDateFilter(FixedListType.DONE, 'Algum Dia'),
                ),
              ],
            ),
            const Divider(),
            ReorderableListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: localList.length,
                itemBuilder: (context, int index) {
                  return Container(
                    key: Key('${localList[index].orderId}'),
                    child: localList[index].type == ItemType.FOLDER
                        ? GestureDetector(
                            onDoubleTap: () => openAddItem(
                                context, ItemType.FOLDER,
                                id: localList[index].key),
                            child: ExpansionTile(
                              title: Text(localList[index].name),
                              leading: Icon(Icons.folder,
                                  color: localList[index].color),
                              childrenPadding: const EdgeInsets.only(left: 10),
                              children: [
                                ReorderableListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      filterFolderList(localList[index].key)
                                          .length,
                                  itemBuilder: (BuildContext context, int i) {
                                    List<Item> subList =
                                        filterFolderList(localList[index].key);
                                    return Container(
                                    key: Key('${subList[i].orderId}'),
                                      child: buildListTile(subList, i, context,
                                          folderId:
                                              loadList.indexOf(localList[index])),
                                    );
                                  },
                                  onReorder: (int oldIndex, int newIndex) {
                                    reoderList(oldIndex, newIndex,
                                        filterFolderList(localList[index].key));
                                  },
                                ),
                              ],
                            ),
                          )
                        : buildListTile(localList, index, context),
                  );
                },
                onReorder: (int oldIndex, int newIndex) {
                  reoderList(oldIndex, newIndex, localList);
                }),
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
                  padding: const EdgeInsets.all(10),
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

  Widget buildListTile(var list, int i, BuildContext context, {int? folderId}) {
    return GestureDetector(
      onDoubleTap: () {
        openAddItem(context, ItemType.LIST,
            id: list[i].key, folderId: folderId);
      },
      child: Container(
        padding: EdgeInsets.only(right: 10),
        child: ListTile(
          title: Text(list[i].name),
          leading: Icon(Icons.list, color: list[i].color),
          trailing: Text(taskCountFilter(list, i).toString()),
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
        ),
      ),
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
    print("ID = ${id}");
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
      loadList = Hive.box("item_list").values.toList().cast<Item>();
      taskList = TaskListRepository.instance.table;
      loadList.sort((a, b) => a.orderId.compareTo(b.orderId));

      Hive.box("item_list").values.toList().cast<Item>().forEach((element) {print("${element.key}: ${element.name}, ${element.type}, ${element}"); });
    });
  }

  int taskCountFilter(var list, int index) {
    return taskList
        .where((element) => element.listId == list[index].key)
        .where((element) => element.finished == false)
        .length;
  }

  List<Item> filterFolderList(int index) {
    return loadList
        .where((element) => element.type == ItemType.LIST)
        .where((element) => (element as ListItem).folderId == index)
        .toList();
  }

  List<TaskList> filterTable(FixedListType type) {
    switch (type) {
      case FixedListType.HOJE:
        {
          return TaskListRepository.instance.table
              .where((element) =>
                  element.date ==
                  formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy]))
              .where((element) => element.finished == false)
              .toList();
        }
      case FixedListType.AMANHA:
        {
          return TaskListRepository.instance.table
              .where((element) =>
                  element.date ==
                  formatDate(DateTime.now().add(const Duration(days: 1)),
                      [dd, '/', mm, '/', yyyy]))
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
      case FixedListType.ALGUMDIA:
        return TaskListRepository.instance.table
            .where((element) => element.date == '')
            .where((element) => element.finished == false)
            .toList();
    }
    return TaskListRepository.instance.table
        .where((element) => element.finished == true)
        .toList();
  }

  void reoderList(int oldIndex, int newIndex, var list) {
    Box box = Hive.box("item_list");
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      //print('old: $oldIndex, new: $newIndex');
      int newOrderId = list[newIndex].orderId;
      if (newIndex > oldIndex) {
        for (int i = newIndex; i > oldIndex; i--) {
         Item item = box.get(list[i].key);
         item.orderId = list[i-1].orderId;
         box.put(item.key, item);
          //list[i].orderId--;
        }
      } else {
        for (int i = newIndex; i < oldIndex; i++) {
          Item item = box.get(list[i].key);
          item.orderId = list[i+1].orderId;
          box.put(item.key, item);
          //list[i].orderId++;
        }
      }
      list[oldIndex].orderId = newOrderId;
      box.put(list[oldIndex].key, list[oldIndex]);

      updateList();
    });
  }
}
