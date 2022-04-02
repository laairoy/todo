import 'package:flutter/material.dart';
import 'package:todo/models/item_list.dart';
import 'package:todo/models/task_list.dart';
import 'package:todo/repositories/task_list_repository.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

class NewTask extends StatelessWidget {
  NewTask({Key? key, required this.task, required this.onSave, required this.listId})
      : super(key: key);

  int listId;
   int task;
  final void Function() onSave;
  List<TaskList> table = TaskListRepository.instance.table;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    canUpdate(_)=> {  print(task)};
    //   final table = TaskListRepository.instance.table;
    return Scaffold(
        appBar: AppBar(
        
           title: Row(
            children: [
             
              Text( 'Criar nova tarefa                                                                                                                                   '),
              Text(_noteController.text = table[task].note.toString()),
              Text(_nameController.text = table[task].name.toString()),
              Text(_dateController.text= table[task].date.toString()),
            ],
          ),
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
                    decoration: InputDecoration(labelText: 'Data'),
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
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Expanded(
                    child: TextFormField(
                      controller: _noteController,
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
                            TaskListRepository.instance.table[task].listId=listId;
                            TaskListRepository.instance.table[task].note=_noteController.text;
                            TaskListRepository.instance.table[task].name=_nameController.text;
                            TaskListRepository.instance.table[task].date=_dateController.text;
                            TaskListRepository.instance.table[task].finished= false;
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
