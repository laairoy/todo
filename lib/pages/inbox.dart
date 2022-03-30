import 'package:flutter/material.dart';
import 'package:todo/repositories/task_list_repository.dart';

class Inbox extends StatefulWidget {
  Inbox({Key? key}) : super(key: key);

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  @override
  Widget build(BuildContext context) {
    final table = TaskListRepository.table;

    return Scaffold(
      appBar: AppBar(
        title: Text('Caixa de entrada'),
      ),
      body: ListView.builder(
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
              setState(() {
                table[task].finished = value;
              });
            },
          );
        },
      ),
    );
  }
}
