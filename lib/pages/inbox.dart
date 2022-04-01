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

  @override
  void initState() {
    super.initState();
    table = TaskListRepository.instance.table
        .where((element) => element.listId == widget.listItem.id)
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
                listId: widget.listItem.id,
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
        child: ListView.builder(
          itemCount: table.length,
          itemBuilder: (BuildContext context, int task) {
            return CheckboxListTile(
              //   leading: table[task].icon,
              title: Text(table[task].name),
              subtitle: Text(table[task].date),
              controlAffinity: ListTileControlAffinity.leading,
              //   trailing: Text(table[task].date),
              key: Key(table[task].name),
              value: table[task].finished,
              onChanged: (value) {
                table[task].finished = value;
                updateState();
              },
            );
          },
        ),
      ),
    );
  }

  void updateState() {
    setState(() {
      widget.onSave();
      table = TaskListRepository.instance.table
          .where((element) => element.listId == widget.listItem.id)
          .where((element) => element.finished == false)
          .toList();
    });
  }
}
