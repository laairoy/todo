import 'package:flutter/material.dart';
import 'package:todo/repositories/task_list_repository.dart';

class inbox extends StatelessWidget {
  inbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final table = TaskListRepository.table;

    return Scaffold(
        appBar: AppBar(
          title: Text('Caixa de entrada'),
        ),
        body: ListView.separated(
          itemBuilder: (BuildContext context, int task) {
            return ListTile(
              leading: table[task].icon,
              title: Text(table[task].name),
              trailing: Text(table[task].date),
            );
          },
          padding: EdgeInsets.all(15),
          separatorBuilder: (_, __) => Divider(),
          itemCount: table.length,
        ));
  }
}
