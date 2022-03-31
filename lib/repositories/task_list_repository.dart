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
        finished: false,
        icon: const Icon(
          Icons.circle,
          color: Color.fromARGB(255, 241, 245, 241),
        ),
        listId: 1,
      ),
      TaskList(
        name: 'Correr',
        date: '11/05/22',
        finished: false,
        icon: const Icon(
          Icons.circle,
          color: Color.fromARGB(255, 241, 245, 241),
        ),
        listId: 1,
      ),
      TaskList(
        name: 'varrer a casa',
        date: '12/06/23',
        finished: true,
        icon: const Icon(
          Icons.circle,
          color: Color.fromARGB(255, 241, 245, 241),
        ),
        listId: 1,
      ),
      TaskList(
        name: 'varrer a casa',
        date: '',
        finished: false,
        icon: const Icon(
          Icons.circle,
          color: Color.fromARGB(255, 241, 245, 241),
        ),
        listId: 3,
      ),
    ];
  }
}
