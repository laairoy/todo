import 'package:flutter/material.dart';
import 'package:todo/models/fixed_list_type.dart';
import 'package:todo/models/task_list.dart';
import 'package:todo/pages/new_task.dart';
import 'package:todo/repositories/task_list_repository.dart';

class TimeTaskList extends StatefulWidget {
  final FixedListType type;
  final String title;
  final void Function() onSave;
  final List<TaskList> Function(FixedListType) filterTable;

  TimeTaskList(
      {Key? key, required this.type, required this.title,required this.filterTable, required this.onSave})
      : super(key: key);

  @override
  State<TimeTaskList> createState() => _TimeTaskListState();
}

class _TimeTaskListState extends State<TimeTaskList> {
  late List<TaskList> table;

  @override
  void initState() {
    super.initState();
    table = widget.filterTable(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
      table = widget.filterTable(widget.type);
    });
  }


}
