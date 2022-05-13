import 'package:flutter/material.dart';
import 'package:todo/models/task_list.dart';
import 'package:date_format/date_format.dart';
import 'package:hive/hive.dart';
import 'package:todo/repositories/task_list_repository.dart';

class NewTask extends StatelessWidget {
  late Box box;

  NewTask({Key? key, int? task, required this.onSave, required this.listId})
      : super(key: key) {
    box = TaskListRepository.instance.taskBox;
    this.task = task ?? -1;
    if (this.task != -1) {
      print(this.task);
      _nameController.text = box.get(task).name;
      _dateController.text = box.get(task).date;
      _noteController.text = box.get(task).note;
    }
  }

  int listId;
  late int task;
  final void Function() onSave;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: task == -1 ? Text('Criar nova tarefa') : Text('Editar tarefa'),
          actions: [
            if(task != -1) IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Deletar"),
                  content: Text("Deseja realmente deletar a tarefa?"),
                  actions: [
                    ElevatedButton(
                      onPressed: () => {
                        //deleteItem(context, list[i].key),
                        box.delete(task),
                        onSave(),
                        Navigator.of(context).pop(),
                        Navigator.pop(context)
                      },
                      child: Text("Deletar"),
                    )
                  ],
                ),
              ),
              icon: Icon(Icons.delete),
              tooltip: 'Deletar tarefa',
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nome da tarefa'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Digite um nome válido';
                    }
                  },
                ),
//            Text('Data'),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            _dateController.text = '';
                          },
                          icon: Icon(
                            Icons.highlight_remove,
                            color: Theme.of(context).colorScheme.onPrimary,
                          )),
                      labelText: 'Data',
                    ),
                    readOnly: true,
                    onTap: () async {
                      var date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100));
                      _dateController.text = formatDate(
                          DateTime.parse(date.toString()),
                          [dd, '/', mm, '/', yyyy]);
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      maxLines: 4,
                      decoration: InputDecoration(
                          labelText: 'Adicionar Nota',
                          border: OutlineInputBorder()),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            if (task != -1) {
                              TaskList tl = box.get(task);
                              tl.listId = listId;
                              tl.note = _noteController.text;
                              tl.name = _nameController.text;
                              tl.date = _dateController.text;
                              tl.finished = false;
                              box.put(tl.key, tl);
                            } else {
                              box.add(TaskList(
                                  name: _nameController.text,
                                  note: _noteController.text,
                                  date: _dateController.text,
                                  finished: false,
                                  listId: listId));
                            }
                            onSave();
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Salvar')),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
