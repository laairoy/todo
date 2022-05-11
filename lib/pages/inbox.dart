import 'package:flutter/material.dart';
import 'package:todo/models/item_list.dart';
import 'package:todo/models/task_list.dart';
import 'package:todo/pages/new_task.dart';
import 'package:todo/repositories/task_list_repository.dart';

class Inbox extends StatefulWidget {
  late Item listItem;

  final void Function() onSave;

  Inbox({Key? key, required this.listItem, required this.onSave})
      : super(key: key);

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  late List<TaskList> table;
  List<TaskList> selecio = [];

  @override
  void initState() {
    super.initState();
    table = TaskListRepository.instance.table
        .where((element) => element.listId == widget.listItem.key)
        .where((element) => element.finished == false)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewTask(
                listId: widget.listItem.key,
                onSave: updateState,
              ),
            ),
          );
        },
        backgroundColor: Color.fromARGB(255, 83, 83, 83),
      ),
      appBar: AppBar(
        title: Text(widget.listItem.name),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: ListView.separated(
          itemCount: table.length,
          itemBuilder: (BuildContext context, int task) {
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewTask(
                      onSave: updateState,
                      task: TaskListRepository.instance.table
                          .indexOf(table[task]),
                      listId: table[task].listId,
                    ),
                  ),
                );
              },
              title: Text(
                table[task].name,
                style: table[task].finished
                    ? TextStyle(decoration: TextDecoration.lineThrough)
                    : TextStyle(),
              ),
              subtitle: table[task].date == '' ? null : Text(table[task].date),
              leading: Checkbox(
                value: table[task].finished,
                onChanged: (bool? value) {
                  setState(() {
                    table[task].finished = value!;
                  });
                  Future.delayed(Duration(milliseconds: 500), updateState);
                },
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
      ),
    );
  }

  void updateState() {
    setState(() {
      widget.onSave();
      table = TaskListRepository.instance.table
          .where((element) => element.listId == widget.listItem.key)
          .where((element) => element.finished == false)
          .toList();
    });
  }
}
