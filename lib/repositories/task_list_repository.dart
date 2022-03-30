import 'package:todo/models/task_list.dart';
import 'package:flutter/material.dart';

class TaskListRepository {
  static List<TaskList> table = [
    TaskList(
      name: 'Estudar',
      date: '10/05/22',
      icon: const Icon(
        Icons.circle,
        color: Color.fromARGB(255, 241, 245, 241),
      ),
    ),
    TaskList(
      name: 'Correr',
      date: '11/05/22',
      icon: const Icon(
        Icons.circle,
        color: Color.fromARGB(255, 241, 245, 241),
      ),
    ),
    TaskList(
      name: 'varrer a casa',
      date: '12/06/23',
      icon: const Icon(
        Icons.circle,
        color: Color.fromARGB(255, 241, 245, 241),
      ),
    ),
  ];
}
