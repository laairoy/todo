import 'package:hive/hive.dart';
import 'package:todo/models/task_list.dart';

class TaskListRepository {
  late Box taskBox;
  static final TaskListRepository _instance = TaskListRepository._();

  static TaskListRepository get instance => _instance;

  TaskListRepository._();

  initData() {
    taskBox.addAll([
      TaskList(
        name: 'Estudar',
        date: '10/05/2022',
        note: 'pampampam',
        finished: false,
        listId: 0,
      ),
      TaskList(
        name: 'Correr',
        date: '11/05/2022',
        note: 'punpunpun',
        finished: false,
        listId: 0,
      ),
      TaskList(
        name: 'Ler Harry',
        date: '12/06/2023',
        note: 'parapapapapara',
        finished: true,
        listId: 0,
      ),
      TaskList(
        name: 'varrer a casa',
        date: '',
        note: 'pipopipopoi',
        finished: false,
        listId: 2,
      )
    ]);
  }
}
