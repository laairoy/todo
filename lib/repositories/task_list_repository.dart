import 'package:todo/models/task_list.dart';
import 'package:flutter/material.dart';

class TaskListRepository {
  List<TaskList> table = [];

  static final TaskListRepository _instance = TaskListRepository._();

  static TaskListRepository get instance => _instance;

  TaskListRepository._() {
    table = [
      TaskList(
        name: 'Estudar',
        date: '10/05/22',
        note: 'pampampam',
        finished: false,
        listId: 1,
      ),
      TaskList(
        name: 'Correr',
        date: '11/05/22',
        note: 'punpunpun',
        finished: false,
        listId: 1,
      ),
      TaskList(
        name: 'varrer a casa',
        date: '12/06/23',
        note: 'parapapapapara',
        finished: true,
        listId: 1,
      ),
      TaskList(
        name: 'varrer a casa',
        date: '',
        note: 'pipopipopoi',
        finished: false,
        listId: 3,
      ),
    ];
  }
}
