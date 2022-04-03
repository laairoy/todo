import 'package:todo/models/task_list.dart';

class TaskListRepository {
  List<TaskList> table = [];

  static final TaskListRepository _instance = TaskListRepository._();

  static TaskListRepository get instance => _instance;

  TaskListRepository._() {
    table = [
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
      ),
    ];
  }
}
