import 'package:flutter/material.dart';
import 'package:todo/models/load_list_repository.dart';
import 'package:todo/models/task_list.dart';
import 'package:todo/repositories/task_list_repository.dart';

class NewTask extends StatelessWidget {
  NewTask({Key? key, required this.listId, required this.onSave })
      : super(key: key);

  int listId;
  final void Function() onSave;
  List<TaskList> table = TaskListRepository.instance.table;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //   final table = TaskListRepository.instance.table;
    return Scaffold(
        appBar: AppBar(
          title: Text('Criar nova tarefa'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome da tarefa'),
              ),
//            Text('Data'),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Data'),
                keyboardType: TextInputType.datetime,
              ),
              Expanded(child: SizedBox()),
              TextField(
                controller: _noteController,
                maxLines: 4,
                decoration: InputDecoration(
                    labelText: 'Adicionar Nota', border: OutlineInputBorder()),
              ),
              ElevatedButton(
                  onPressed: () {
                    //  print(table[2].name);
                    //   print(table[4].name);
                    //    print(table[9].name);
                    TaskListRepository.instance.table.add(TaskList(
                        name: _nameController.text,
                        note: _noteController.text,
                        date: _dateController.text,
                        finished: false,
                        listId: listId));
                    onSave();
                    Navigator.pop(context);
                  },
                  child: Text('Salvar')),
            ],
          ),
        ));
  }
}
