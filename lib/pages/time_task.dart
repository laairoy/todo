import 'package:flutter/material.dart';
import 'package:todo/models/fixed_list_type.dart';
import 'package:todo/models/task_list.dart';

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
      table = widget.filterTable(widget.type);
    });
  }


}
